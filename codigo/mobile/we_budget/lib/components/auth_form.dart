import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../exceptions/auth_exception.dart';
import '../models/auth.dart';
import '../utils/app_routes.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.login;
  bool _isSignup() => _authMode == AuthMode.signup;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signup;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um Erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(
      () => _isLoading = true,
    );

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        // Login
        await auth.login(
          _authData['name']!,
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        // Registrar
        await auth.signup(
          _authData['name']!,
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(
      () => _isLoading = false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsetsDirectional.only(top: 0.0), //Nataniel
      child: Card(
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(2),
          height: _isLogin() ? 400 : 460,
          width: deviceSize.width * 0.95,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_isSignup())
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      key: const ValueKey('name'),
                      initialValue: _authData['name'],
                      onChanged: (name) => _authData['name'] = name,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        hintText: "Digite aqui seu nome",
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onSaved: (name) => _authData['name'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';
                        if (name.trim().isEmpty) {
                          return 'Dados inválidos';
                        }
                        return null;
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextFormField(
                    key: const ValueKey('email'),
                    initialValue: _authData['email'],
                    onChanged: (email) => _authData['email'] = email,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      hintText: "Digite aqui seu e-mail",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onSaved: (email) => _authData['email'] = email ?? '',
                    validator: (_email) {
                      final email = _email ?? '';
                      if (email.trim().isEmpty || !email.contains('@')) {
                        return 'Informe um e-mail válido';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextFormField(
                    key: const ValueKey('password'),
                    onChanged: (password) => _authData['password'] = password,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      hintText: "Digite aqui sua senha",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    controller: _passwordController,
                    onSaved: (password) =>
                        _authData['password'] = password ?? '',
                    validator: (_password) {
                      final password = _password ?? '';
                      if (password.isEmpty || password.length < 3) {
                        return 'Informe uma senha válida';
                      }
                      return null;
                    },
                  ),
                ),
                if (_isSignup())
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      key: const ValueKey('confirmacaoSenha'),
                      decoration: const InputDecoration(
                        labelText: 'Confirmar Senha',
                        hintText: "Digite a confirmação da senha",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      validator: _isLogin()
                          ? null
                          : (_password) {
                              final password = _password ?? '';
                              if (password != _passwordController.text) {
                                return 'Senhas informadas não conferem.';
                              }
                              return null;
                            },
                    ),
                  ),
                const SizedBox(height: 8),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    /*onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.main);
                    }, //ajustar*/
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      fixedSize: const Size(290, 40),
                      backgroundColor: const Color.fromARGB(255, 102, 91, 196),
                    ),
                    child: Text(
                      _authMode == AuthMode.login ? 'ENTRAR' : 'CADASTRAR',
                      textAlign: TextAlign.left,
                    ),
                  ),
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 5.0),
                  child: ElevatedButton(
                    onPressed: _switchAuthMode,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      fixedSize: const Size(290, 40),
                      backgroundColor: const Color.fromARGB(255, 102, 91, 196),
                    ),
                    child: Text(
                      _isLogin() ? 'CADASTRAR?' : 'JÁ POSSUI CONTA?',
                    ),
                  ),
                ),
                if (!_isSignup())
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 15.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        fixedSize: const Size(200, 20),
                        backgroundColor: Color(0xFF4C94F8),
                      ),
                      child: const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Text("TUTORIAL WEBUDGET")),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.carroselTutorial);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

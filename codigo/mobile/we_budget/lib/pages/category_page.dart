import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:provider/provider.dart';
import '../Repository/categoria_repository.dart';
import '../exceptions/auth_exception.dart';
import '../models/categoria_model.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final _formKeyCreateCategory = GlobalKey<FormState>();
  final Map<String, dynamic> _createCategoryData = {
    'nameCreateCategory': '',
    'codeCreateCategory': '',
  };
  int? codigoCreateCategory = 984405;
  bool isLoading = false;

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    setState(() {
      codigoCreateCategory = icon?.codePoint;
      _createCategoryData['codeCreateCategory'] = codigoCreateCategory!.toInt();
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreo um Erro'),
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

  Future<void> _submitCreateCategory() async {
    final isValid = _formKeyCreateCategory.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    _formKeyCreateCategory.currentState?.save();

    setState(
      () => isLoading = true,
    );
    RepositoryCategory category = Provider.of(context, listen: false);

    try {
      await category.saveTransactionSql(_createCategoryData).then(
            (value) => Navigator.of(context).pop(),
          );
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }
  }

  void _loadFormDataCategory(CategoriaModel categoria) {
    _createCategoryData['Id'] = categoria.id;
    _createCategoryData['nameCreateCategory'] = categoria.nameCategoria;
    _createCategoryData['codeCreateCategory'] = categoria.codeCategoria;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    if (ModalRoute.of(context)!.settings != null &&
        ModalRoute.of(context)!.settings.arguments != null) {
      final argument =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      String page = argument['page'] as String;
      Object data = argument['itemByIndex'];

      if (page == 'listCategory') {
        setState(() {
          _loadFormDataCategory(data as CategoriaModel);

          codigoCreateCategory =
              int.parse(_createCategoryData['codeCreateCategory']);
        });
      } else {
        codigoCreateCategory = 984405;
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF923DF8),
                  Color(0xFF4C94F8),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF923DF8),
              Color(0xFF4C94F8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.only(top: 0),
          child: Container(
            height: height * 1,
            margin: const EdgeInsetsDirectional.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20),
                topEnd: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: const [
                    Text(
                      "Cadastrar Categoria",
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 28,
                        color: Colors.blueGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKeyCreateCategory,
                    child: Column(
                      children: [
                        Container(
                          margin:
                              const EdgeInsetsDirectional.only(bottom: 30.0),
                          child: TextFormField(
                            key: const ValueKey('descricao'),
                            initialValue:
                                _createCategoryData['nameCreateCategory']
                                    .toString(),
                            decoration: const InputDecoration(
                              labelText: 'Descrição',
                              hintText: "Digite aqui o nome da Categoria",
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onSaved: (nameCreateCategory) =>
                                _createCategoryData['nameCreateCategory'] =
                                    nameCreateCategory.toString(),
                            onChanged: (nameCreateCategory) =>
                                _createCategoryData['nameCreateCategory'] =
                                    nameCreateCategory.toString(),
                            validator: (validacao) {
                              final name = validacao ?? '';
                              if (name.trim().isEmpty) {
                                return 'Dados inválidos';
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _pickIcon,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 102, 91, 196),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            fixedSize: const Size(290, 43),
                          ),
                          child: const Text(
                            'Clique aqui para escolher o ícone',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 90,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Icon(
                          IconData(codigoCreateCategory ?? 0,
                              fontFamily: 'MaterialIcons'),
                          size: 50,
                          color: const Color.fromARGB(255, 102, 91, 196),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoading)
                        const CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: _submitCreateCategory,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            fixedSize: const Size(290, 40),
                            backgroundColor:
                                const Color.fromARGB(255, 102, 91, 196),
                          ),
                          child: const Text(
                            "Cadastrar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                    ],
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

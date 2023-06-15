import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:we_budget/Repository/account_repository.dart';
import 'package:we_budget/Repository/categoria_repository.dart';
import 'package:we_budget/Repository/metas_repository.dart';
import 'package:we_budget/Repository/transaction_repository.dart';
import 'package:we_budget/components/menu_component.dart';
import 'package:we_budget/models/auth.dart';
import 'package:we_budget/pages/auth_or_home_page.dart';
import 'package:we_budget/pages/carrossel_page.dart';
import 'package:we_budget/pages/category_page.dart';
import 'package:we_budget/pages/create_meta.dart';
import 'package:we_budget/pages/edit_data_login.dart';
import 'package:we_budget/pages/init_page.dart';
import 'package:we_budget/pages/list_category_page.dart';
import 'package:we_budget/pages/list_transactions_page.dart';
import 'package:we_budget/pages/location_form.dart';
import 'package:we_budget/pages/login_page.dart';
import 'package:we_budget/pages/main_page.dart';
import 'package:we_budget/pages/registrar_transacao_page.dart';
import 'package:we_budget/utils/app_routes.dart';
import 'package:we_budget/utils/sqflite.dart';
import 'package:we_budget/utils/update_local_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Aplicação Inicial");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, RepositoryTransaction>(
          create: (_) => RepositoryTransaction(),
          update: (context, auth, previous) {
            return RepositoryTransaction();
          },
        ),
        ChangeNotifierProxyProvider<Auth, RepositoryCategory>(
          create: (_) => RepositoryCategory(),
          update: (context, auth, previous) {
            return RepositoryCategory();
          },
        ),
        ChangeNotifierProxyProvider<Auth, RepositoryAccount>(
          create: (_) => RepositoryAccount(),
          update: (context, auth, previous) {
            return RepositoryAccount();
          },
        ),
        ChangeNotifierProxyProvider<Auth, RepositoryMetas>(
          create: (_) => RepositoryMetas(),
          update: (context, auth, previous) {
            return RepositoryMetas();
          },
        ),
        ChangeNotifierProxyProvider<Auth, UpdateLocalDatabase>(
          create: (_) => UpdateLocalDatabase(),
          update: (context, auth, previous) {
            return UpdateLocalDatabase();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey,
          ).copyWith(
            secondary: Colors.amber,
          ),
        ),
        localizationsDelegates: const [
          MonthYearPickerLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.initPage: (ctx) => const InitPage(),
          AppRoutes.authOrHome: (ctx) => const AuthOrHomePage(),
          AppRoutes.login: (ctx) => const LoginPage(),
          AppRoutes.main: (ctx) => const MainPage(),
          AppRoutes.formTransaction: (ctx) => const TransacaoFormPage(),
          AppRoutes.listCategory: (ctx) => const ListCategoryPage(),
          AppRoutes.createCategory: (ctx) => const CreateCategory(),
          AppRoutes.placeForm: (ctx) => const PlaceFormScreen(),
          AppRoutes.listTransactions: (ctx) => const ListTransactionsPage(),
          AppRoutes.createMeta: (ctx) => const CreateMeta(),
          AppRoutes.menuPrincipal: (ctx) => const MenuPrincipal(),
          AppRoutes.editDataUser: (ctx) => const EditDataUser(),
          AppRoutes.carroselTutorial: (ctx) => const CarroselTutorial(),
        },
      ),
    );
  }
}

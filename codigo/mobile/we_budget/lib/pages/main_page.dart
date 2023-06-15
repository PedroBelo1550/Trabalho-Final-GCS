import 'package:flutter/material.dart';
import 'package:we_budget/pages/welcome_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela inicial"),
      ),
      bottomNavigationBar: const WelcomePage(),
    );
  }
}

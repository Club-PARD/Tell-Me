import 'package:flutter/material.dart';

import 'package:tell_me/view/loginView.dart';
import 'package:tell_me/view/signupView.dart';
import 'package:tell_me/view/homeView.dart';

class TellMe extends StatelessWidget {
  const TellMe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tellme',
      initialRoute: '/signup/login',
      routes: {
        '/': (BuildContext context) => const HomeView(),
        '/login': (BuildContext context) => const LoginView(),
        '/signup': (BuildContext context) => const SignupView(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
    );
  }
}
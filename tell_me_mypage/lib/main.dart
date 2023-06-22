import 'package:flutter/material.dart';
import 'package:tell_me_mypage/view/my_page.dart';
import 'package:tell_me_mypage/view/signUp_interest_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const signUpInterestPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:youtube/view/homeView.dart';
import 'package:youtube/view/writeView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube API',
      initialRoute: '/write',
      routes: {
        '/home': (context) => HomeScreen(
            id: ModalRoute.of(context)!.settings.arguments as String),
        '/write': (context) => const WriteScreen(),
      },
    );
  }
}

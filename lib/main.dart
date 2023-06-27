import 'package:flutter/material.dart';
import 'package:middle_ui/screens/core_music_add.dart';
import 'package:middle_ui/screens/make_room.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/makeroom',
      routes: {
        '/makeroom': (context)=> const MakeRoom(),
        '/coremusicadd':(context) => const CoreMusicAdd(),
      },
    );
  }
}

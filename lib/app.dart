import 'package:dlive/screens/splash_page.dart';
import 'package:dlive/screens/login_page.dart';
import 'package:dlive/screens/signup_page1.dart';
import 'package:dlive/screens/signup_page2.dart';
import 'package:dlive/screens/signup_page3.dart';
import 'package:dlive/screens/home_page.dart';
import 'package:dlive/screens/core_music_add.dart';
import 'package:dlive/screens/room_list_screen.dart';
import 'package:dlive/screens/make_room.dart';
import 'package:flutter/material.dart';

class DLive extends StatelessWidget {
  const DLive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DLive',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/': (BuildContext context) => const LoginPage(),
        '/signup1': (context) => const SignUpPage1(),
        '/signup2': (context) => const SignUpPage2(),
        '/signup3': (context) => const SignUpPage3(),
        '/home': (context) => const HomePage(),
        '/roomlist': (context) => const RoomListScreen(),
        '/makeroom': (context) => const MakeRoom(),
        '/coremusicadd': (context) => const CoreMusicAdd(),
      },
    );
  }
}

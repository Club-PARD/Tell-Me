import 'package:flutter/material.dart';
import 'package:dlive/services/login_service.dart';
import 'package:dlive/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.background,
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 117,
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 812 * 102,
                ),
                Image.asset(
                  'assets/logo_image.png',
                  height: MediaQuery.of(context).size.height / 812 * 130,
                  width: MediaQuery.of(context).size.height / 812 * 130,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 812 * 34,
                ),
                const Text(
                  '환영합니다!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 812 * 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo_text_black.png',
                      height: MediaQuery.of(context).size.height / 812 * 24,
                      width: MediaQuery.of(context).size.width / 375 * 68,
                    ),
                    const Text(
                      '에서 활동하기 위해서는',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Text(
                  '계정생성이 필요해요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 812 * 60,
                ),
                FutureBuilder(
                  future: Authentication.initializeFirebase(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error initializing Firebase');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return const GoogleSignInButton();
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 812 * 50,
                ),
                Image.asset(
                  'assets/agree.png',
                  width: MediaQuery.of(context).size.width / 375 * 252,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

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
                  height: MediaQuery.of(context).size.height / 812 * 113,
                ),
                const Text(
                  '환영합니다!\n\nD-LIVE에서 활동하기 위해서는\n계정생성이 필요해요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 812 * 50,
                ),
                GestureDetector(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 812 * 46,
                    width: MediaQuery.of(context).size.width / 375 * 249,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height:
                                MediaQuery.of(context).size.height / 812 * 24,
                            width:
                                MediaQuery.of(context).size.height / 812 * 24,
                            child: Image.asset('assets/google_login.png')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 375 * 10,
                        ),
                        Text(
                          '구글로 로그인 하기',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  onTap: () async {
                    final credential = await signInWithGoogle();
                    Navigator.pushNamed(context, '/signup1');
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 812 * 15,
                ),
                GestureDetector(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 812 * 46,
                    width: MediaQuery.of(context).size.width / 375 * 249,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        '일단 둘러보고 싶어요',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    // Navigator.pushNamed(context, '/navigation');
                    Navigator.pushNamed(context, '/signup1');
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

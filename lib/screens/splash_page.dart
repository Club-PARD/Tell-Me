import 'package:flutter/material.dart';
import 'package:dlive/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:transition/transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String uid = '';
  static final sStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러옴.
    //이때 불러오는 결과의 타입은 String 타입임.
    //(데이터가 없을때는 null을 반환)
    uid = (await sStorage.read(key: "login"))!;
    print(uid);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (uid == null) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    } else {
      Navigator.popAndPushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.background,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 812 * 177,
            ),
            const Text(
              '함께 듣는 즐거움\nDLIVE!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 812 * 37,
            ),
            Image.asset(
              'assets/logo_image.png',
              height: MediaQuery.of(context).size.height / 812 * 174,
              width: MediaQuery.of(context).size.height / 812 * 174,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 812 * 27,
            ),
            Image.asset(
              'assets/logo_text_white.png',
              height: MediaQuery.of(context).size.height / 812 * 61,
              width: MediaQuery.of(context).size.height / 375 * 200,
            ),
          ],
        ),
      ),
    );
  }
}

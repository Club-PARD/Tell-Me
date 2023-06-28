import 'package:flutter/material.dart';
import 'package:dlive/constants.dart';

class SignUpPage3 extends StatefulWidget {
  const SignUpPage3({super.key});

  @override
  State<SignUpPage3> createState() => _SignUpPage3State();
}

class _SignUpPage3State extends State<SignUpPage3> {

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
            height: MediaQuery.of(context).size.height / 812 * 95,
          ),
          const Text(
            'D-LIVE에 오신 ㅇㅇ님\n즐거운 드라이브 하세요',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 48,
          ),
          ClipOval(
            child: Container(
              color: Color(0xffD9D9D9),
              height: MediaQuery.of(context).size.height / 812 * 240,
              width: MediaQuery.of(context).size.height / 812 * 240,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 227,
          ),
          GestureDetector(
            child: Container(
              height: MediaQuery.of(context).size.height / 812 * 46,
              width: MediaQuery.of(context).size.width / 375 * 249,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                child: Text(
                  '확인',
                  style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ]),
      ),
    );
  }
}
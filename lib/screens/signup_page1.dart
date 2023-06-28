import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dlive/constants.dart';

class SignUpPage1 extends StatelessWidget {
  const SignUpPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.background,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 140,
        ),
        const Text(
          '당신을 대표할 캐릭터를 골라주세요',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 66,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 375 * 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Text('캐릭터$index');
            },
            separatorBuilder: (context, index) => ClipOval(
              child: Container(
                color: Color(0xffD9D9D9),
                height: MediaQuery.of(context).size.width / 375 * 240,
                width: MediaQuery.of(context).size.width / 375 * 240,
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 177,
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
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/signup2');
          },
        ),
      ]),
    );
  }
}

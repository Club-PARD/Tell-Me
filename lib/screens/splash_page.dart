import 'package:flutter/material.dart';
import 'package:dlive/constants.dart';
import 'dart:async';
import 'package:transition/transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
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
                    height: MediaQuery.of(context).size.height / 812 * 161,
                  ),
                  const Text('함께 듣는 즐거움\nDLIVE!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 812 * 32,
                  ),
                  ClipOval(
                    child: Container(
                      color: Color(0xffD9D9D9),
                      height: MediaQuery.of(context).size.height / 812 * 218,
                      width: MediaQuery.of(context).size.height / 812 * 218,
                      child: Center(child: Text('서비스 로고')),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 812 * 52.5,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 812 * 245,
                  ),
                  Text('준비를 마칠 때까지 기다려주세요...',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
      ),
    );
  }
}

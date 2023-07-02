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
                    height: MediaQuery.of(context).size.height / 812 * 177,
                  ),
                  const Text('함께 듣는 즐거움\nDLIVE!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 812 * 37,
                  ),
                  Image.asset('assets/logo_image.png', height: MediaQuery.of(context).size.height / 812 * 174, width: MediaQuery.of(context).size.height / 812 * 174,),
                  SizedBox(height: MediaQuery.of(context).size.height / 812 * 27,),
                  Image.asset('assets/logo_text_white.png', height: MediaQuery.of(context).size.height / 812 * 61, width: MediaQuery.of(context).size.height / 375 * 200,),
                ],
              ),
      ),
    );
  }
}

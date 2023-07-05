import 'dart:async';

import 'package:flutter/material.dart';

import '../constants.dart';

class MakeRoomWaitingScreen extends StatefulWidget {
  const MakeRoomWaitingScreen({Key? key}) : super(key: key);

  @override
  State<MakeRoomWaitingScreen> createState() => _MakeRoomWaitingScreenState();
}

class _MakeRoomWaitingScreenState extends State<MakeRoomWaitingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushNamed(
            context, '/makeroomqr'); // 2초 후 '/makeroomqr' 페이지로 이동
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 812 * 84,
              ),
              const Text(
                '곧 QR 코드가 만들어져요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 812 * 20,
              ),
              const Text(
                'QR 코드 링크를 통해 친구들을 자유롭게 초대해\n즐거운 드라이브를 경험해보세요',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 812 * 37,
              ),
              Image.asset(
                'assets/car_moving_final.gif',
                height: MediaQuery.of(context).size.height / 812 * 350,
                //width: MediaQuery.of(context).size.height / 812 * 492,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 812 * 27,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

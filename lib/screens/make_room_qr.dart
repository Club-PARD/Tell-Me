import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MakeRoomQrScreen extends StatefulWidget {
  const MakeRoomQrScreen({Key? key}) : super(key: key);

  @override
  _MakeRoomQrScreenState createState() => _MakeRoomQrScreenState();
}

class _MakeRoomQrScreenState extends State<MakeRoomQrScreen> {
  bool isCopied = false;

  void _showCopiedMessage() {
    setState(() {
      isCopied = true;
    });
    Fluttertoast.showToast(
      msg: '복사 완료!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isCopied = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "내 QR 코드",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text(
              '확인',
              style: TextStyle(color: Color(0xFF4D4D4D), fontSize: 16),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Dlive_backG.png"),
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),

              //사용자 profile 이미지
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/QR_backG.png',
                        width: MediaQuery.of(context).size.width / 1.5,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height /
                            3.3, // 추가 이미지의 위치 조정

                        child: Image.asset(
                          'assets/images/Dlive_qr_example.png', // 추가 이미지의 경로
                          width: MediaQuery.of(context).size.width /
                              1.8, // 추가 이미지의 너비 조정
                          height: MediaQuery.of(context).size.width /
                              1.8, // 추가 이미지의 높이 조정
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 300,
              ),
              // Text(
              //   '이번엔 칠포다.',
              //   style: TextStyle(color: Colors.white, fontSize: 15),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height / 20,
              // ),

              //QR이미지
              // Expanded(
              //   child: Container(
              //     width: 230,
              //     height: 230,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     padding: EdgeInsets.all(10),
              //     child: Image.asset(
              //       'assets/images/QR_Code_example.png',
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 13,
              ),

              //"링크 공유" 버튼
              ElevatedButton(
                onPressed: () {
                  _showCopiedMessage();
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 45),
                  primary: Colors.white.withOpacity(0.5), // 반투명한 색상
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  '링크공유',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

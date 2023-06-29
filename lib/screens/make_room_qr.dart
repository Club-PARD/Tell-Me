import 'package:flutter/material.dart';

class MakeRoomQrScreen extends StatelessWidget {
  const MakeRoomQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "친구들 초대하기",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),

            //사용자 profile 이미지
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/profile.png',
                  width: 140,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
            ),
            Text(
              '이번엔 칠포다.',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),

            //QR이미지
            Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/QR_Code_example.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),

            //"링크 공유" 버튼
            ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ()));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(280, 45),
                  primary: Color(0XFFCBCBCB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '링크공유',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}

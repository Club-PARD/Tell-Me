import 'package:flutter/material.dart';
import 'package:dlive/constants.dart';

class SignUpPage2 extends StatefulWidget {
  const SignUpPage2({super.key});

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.background,
      body: Container(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 95,
          ),
          const Text(
            '멋진 캐릭터네요!\n이름은 무엇인가요?',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 35,
          ),
          ClipOval(
            child: Container(
              color: Color(0xffD9D9D9),
              height: MediaQuery.of(context).size.height / 812 * 240,
              width: MediaQuery.of(context).size.height / 812 * 240,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 35,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xff888888),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: '이름',
                  hintStyle: TextStyle(
                    color: Color(0xff9C9C9C),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 812 * 5,
              ),
              Text(
                '이름은 언제든 바꿀 수 있어요.',
                style: TextStyle(fontSize: 14, color: Color(0xff626262)),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 112,
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
              Navigator.pushNamed(context, '/signup3');
            },
          ),
        ]),
      ),
    );
  }
}

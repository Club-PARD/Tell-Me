import 'package:dlive/utils/host_util.dart';
import 'package:flutter/material.dart';
import 'package:dlive/constants.dart';
import 'package:provider/provider.dart';

class SignUpPage2 extends StatefulWidget {
  const SignUpPage2({super.key});

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hostProvider = Provider.of<HostProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 812 * 81,
            ),
            const Text(
              '멋진 캐릭터네요!\n이름은 무엇인가요?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 812 * 15,
            ),
            Image.asset(
              hostProvider.character,
              width: MediaQuery.of(context).size.width / 375 * 279,
              height: MediaQuery.of(context).size.height / 812 * 280,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 812 * 37,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(33, 0, 33, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffE4E4E4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
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
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 812 * 149,
            ),
            GestureDetector(
              child: Container(
                height: MediaQuery.of(context).size.height / 812 * 46,
                width: MediaQuery.of(context).size.width / 375 * 249,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Center(
                  child: Text(
                    '확인',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                hostProvider.setName(_textController.text);
                Navigator.pushNamed(context, '/signup3');
              },
            ),
          ]),
        ),
      ),
    );
  }
}

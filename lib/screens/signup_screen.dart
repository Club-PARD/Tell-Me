import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:dlive/utils/host_util.dart';
import 'package:provider/provider.dart';

class SignUpPage1 extends StatefulWidget {
  const SignUpPage1({super.key});

  @override
  State<SignUpPage1> createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1> {
  @override
  Widget build(BuildContext context) {
    final hostProvider = Provider.of<HostProvider>(context);

    List<String> character = [
      'assets/character_pale.png',
      'assets/character_pink.png',
      'assets/character_yellow.png',
      'assets/character_green.png',
      'assets/character_blue.png',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 140,
        ),
        const Text(
          '당신을 대표할 캐릭터를 골라주세요',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 58,
        ),
        ExpandableCarousel(
          options: CarouselOptions(
              autoPlay: false,
              showIndicator: false,
              onPageChanged: (index, reason) {
                hostProvider.setCharacter(character[index]);
                print(hostProvider.character);
              }),
          items: [0, 1, 2, 3, 4].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Image.asset(
                    character[i],
                    width: MediaQuery.of(context).size.width / 375 * 279,
                    height: MediaQuery.of(context).size.height / 812 * 280,
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 145,
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
            Navigator.pushNamed(context, '/signup2');
          },
        ),
      ]),
    );
  }
}

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

class SignUpPage3 extends StatefulWidget {
  const SignUpPage3({super.key});

  @override
  State<SignUpPage3> createState() => _SignUpPage3State();
}

class _SignUpPage3State extends State<SignUpPage3> {
  late HostUtil hostUtil = HostUtil();

  @override
  Widget build(BuildContext context) {
    final hostProvider = Provider.of<HostProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 82,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo_text_black.png',
                height: MediaQuery.of(context).size.height / 812 * 24,
                width: MediaQuery.of(context).size.width / 375 * 68,
              ),
              Text(
                '에 오신 ${Provider.of<HostProvider>(context).name}님,',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Text(
            '즐거운 드라이브 하세요',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 48,
          ),
          Image.asset(
            Provider.of<HostProvider>(context).character,
            width: MediaQuery.of(context).size.width / 375 * 279,
            height: MediaQuery.of(context).size.height / 812 * 280,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 227,
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
              hostUtil.addHost(hostProvider.name, hostProvider.email, hostProvider.character);
              
              Navigator.pushNamed(context, '/navigation');
            },
          ),
        ]),
      ),
    );
  }
}



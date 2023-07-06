import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';

import 'package:dlive/utils/host_util.dart';

class ProfileCharacterScreen extends StatefulWidget {
  const ProfileCharacterScreen({Key? key}) : super(key: key);

  @override
  _ProfileCharacterScreenState createState() => _ProfileCharacterScreenState();
}

class _ProfileCharacterScreenState extends State<ProfileCharacterScreen> {
  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    List<String> character = [
      'assets/character_pale.png',
      'assets/character_pink.png',
      'assets/character_yellow.png',
      'assets/character_green.png',
      'assets/character_blue.png',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 140,
          ),
          const Text(
            '당신을 대표할 캐릭터를 골라주세요',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 58,
          ),
          ExpandableCarousel(
            options: CarouselOptions(
              autoPlay: false,
              showIndicator: false,
              onPageChanged: (index, reason) {
                profileProvider.setCharacter(character[index]);
                print(profileProvider.character);
              },
            ),
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
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Center(
                child: Text(
                  '확인',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            onTap: () {
              if (profileProvider.character == '') {
                profileProvider.setCharacter(character[0]);
              }
              Navigator.pushNamed(context, '/profilecharacter2');
            },
          ),
        ],
      ),
    );
  }
}

class ProfileCharacter2Screen extends StatefulWidget {
  const ProfileCharacter2Screen({super.key});

  @override
  State<ProfileCharacter2Screen> createState() =>
      _ProfileCharacter2ScreenState();
}

class _ProfileCharacter2ScreenState extends State<ProfileCharacter2Screen> {
  late HostUtil hostUtil = HostUtil();

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

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
                '에 오신 ${profileProvider.name}님,',
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
            profileProvider.character,
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
                  '시작하기',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/profile'));
            },
          ),
        ]),
      ),
    );
  }
}

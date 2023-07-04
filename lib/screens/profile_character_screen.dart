import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';

import '../utils/host_util.dart';

class ProfileCharacterScreen extends StatefulWidget {
  const ProfileCharacterScreen({super.key});

  @override
  State<ProfileCharacterScreen> createState() => _ProfileCharacterScreenState();
}

class _ProfileCharacterScreenState extends State<ProfileCharacterScreen> {
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

    String selectedCharacter = character[0];

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
            Navigator.pushNamed(context, '/profilecharacter2');
          },
        ),
      ]),
    );
  }
}

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dlive/services/gpt_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dart_openai/dart_openai.dart';

class StationLoadingScreen extends StatefulWidget {
  const StationLoadingScreen({super.key});

  @override
  State<StationLoadingScreen> createState() => _StationLoadingScreenState();
}

class _StationLoadingScreenState extends State<StationLoadingScreen> {
  GptService gptService = GptService();

  @override
  Widget build(BuildContext context) {
    OpenAI.apiKey = dotenv.env['OPENAI_API_KEY']!;
    List<List<String>> selections = [
      ['지코 - Artist', '호미들 - 사이렌', '창모 - METHEO'],
      ['아이유 - 팔레트', '폴킴 - 모든 날 모든 순간', ''],
      ['김동률 - 감사', '', ''],
      ['닐로 - 지나오다', '양다일 - 미안해', ''],
      ['', '', ''],
      ['', '', ''],
    ];

    List<List<String>> songs;

    int time = 60; //min
    String numOfSongs = (time / 3).toStringAsFixed(0);

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<List<List<String>>>(
            future: gptService.songs(
              selections,
              gptService.generateText(selections, numOfSongs),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Stack(
                  children: [
                    Positioned(
                    top: MediaQuery.of(context).size.height / 812 * 149,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 812 * 544,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/car_moving_2.gif'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 812 * 21,
                          ),
                          Text(
                            '곧 스테이션이 만들어져요!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 812 * 41,
                          ),
                          Text(
                            '모든 사람들의 곡을 받고\n플레이리스트를 생성 중입니다...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 812 * 41,
                          ),
                          Text(
                            '그동안 동승자의 안부를 물어보는건 어때요?',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError ||
                  snapshot.data!.length < int.parse(numOfSongs)) {
                print('Error: ${snapshot.error}');
                return Stack(
                  children: [
                    Positioned(
                    top: MediaQuery.of(context).size.height / 812 * 149,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 812 * 544,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/car_moving_2.gif'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 812 * 21,
                          ),
                          Text(
                            '죄송합니다.\n스테이션을 다시 생성해주세요',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 812 * 537,
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
                                  '스테이션 생성하기',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                print(snapshot.data!.length);
                songs = snapshot.data!;
                print(songs);
                return Stack(
                  children: [
                    Positioned(
                    top: MediaQuery.of(context).size.height / 812 * 149,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 812 * 544,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/car_moving_2.gif'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 812 * 28,
                        ),
                        Text(
                          '스테이션 생성 완료!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 812 * 41,
                        ),
                        Text(
                          '오래 기다렸습니다,\n이제 들으러 가시죠',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 812 * 457,
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
                                '입장하기',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/stationmain');
                          },
                        ),
                      ]),
                    ),
                  ],
                );
              }
            }));
  }
}

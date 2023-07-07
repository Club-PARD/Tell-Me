import 'package:flutter/material.dart';
import 'package:dlive/utils/room_util.dart';
import 'package:dlive/utils/host_util.dart';
import 'package:provider/provider.dart';

class MakeRoomExplainpage extends StatelessWidget {
  const MakeRoomExplainpage({super.key});

  @override
  Widget build(BuildContext context) {
    final hostProvider = Provider.of<HostProvider>(context);
    final roomProvider = Provider.of<RoomProvider>(context);

    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height / 812 * 23),
              const Text(
                '곧 스테이션이 만들어져요!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: height / 812 * 23),
              const Text(
                '음악 3개를 선택하시면 AI가 유사한 장르의 노래를\n대신 선곡해줘 즐거운 드라이브 경험을 완성시켜줄거에요',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              SizedBox(height: height / 812 * 30),
              Stack(
                children: [
                  Image.asset(
                    'assets/making_room.png',
                    height: MediaQuery.of(context).size.height / 812 * 226,
                    width: MediaQuery.of(context).size.width / 375 * 287,
                  ),
                  Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Text(
                      '@${roomProvider.name}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 812 * 244),
              GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height / 812 * 46,
                  width: MediaQuery.of(context).size.width / 375 * 249,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Center(
                    child: Text(
                      '음악 선택하러 가기',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/coremusicadd');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

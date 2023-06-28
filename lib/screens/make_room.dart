import 'package:flutter/material.dart';

class MakeRoom extends StatefulWidget {
  const MakeRoom({super.key});

  @override
  _MakeRoomState createState() => _MakeRoomState();
}

class _MakeRoomState extends State<MakeRoom> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: const Icon(Icons.close),
        ),
        title: const Text(
          '그룹청취방 정보 설정',
          style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/coremusicadd');
              },
              child: const Text(
                '확인',
                style: TextStyle(color: Color(0XFFFFFFFF)),
              )),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          SizedBox(
            // width: width,
            height: height * 0.001,
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: const Color(0XFFD9D9D9),
                ),
                width: height * 0.17,
                height: height * 0.17,
                child: const Center(
                  child: Text(
                    '로고',
                    style: TextStyle(color: Color(0XFF9C9C9C)),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 6,
                child: GestureDetector(
                  onTap: () {
                    _showDialog(context);
                  },
                  child: Image.asset(
                    'assets/images/camera.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.005),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: '디라이브와 함께!',
                        hintStyle: TextStyle(color: Color(0XFF9C9C9C)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          const Text(
            '음악 재생전, 내가 설정한 그룹청취방의 사진과 이름은\n 다른 모든 멤버에게도 동일하게 보입니다.',
            style: TextStyle(color: Color(0XFF9C9C9C)),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> _showDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            actions: [
              Center(
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          '대표 사진 설정',
                          style: TextStyle(color: Color(0XFF383838)),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          '앨범에서 사진/동영상 선택',
                          style: TextStyle(color: Color(0XFF383838)),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          '기본 이미지로 변경',
                          style: TextStyle(color: Color(0XFF383838)),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          '취소',
                          style: TextStyle(color: Color(0XFF383838)),
                        )),
                  ],
                ),
              )
            ],
          ));
}

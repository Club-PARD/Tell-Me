import 'package:dlive/screens/core_music_add_select.dart';
import 'package:flutter/material.dart';

class CoreMusicAdd extends StatefulWidget {
  const CoreMusicAdd({Key? key}) : super(key: key);

  @override
  State<CoreMusicAdd> createState() => _CoreMusicAddState();
}

class _CoreMusicAddState extends State<CoreMusicAdd> {
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
        elevation: 0,
        backgroundColor: const Color(0XFFD9D9D9),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          '내 코어 음악 추가',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CoreMusicAddSelectScreen()));
              },
              child: const Text(
                '확인',
                style: TextStyle(color: Color(0XFFFFFFFF)),
              )),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.23,
            decoration: const BoxDecoration(color: Color(0XFFD9D9D9)),
            child: Column(
              children: [
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
                              hintText: '곡, 앨범, 아티스트 명으로 검색',
                              hintStyle: TextStyle(color: Color(0XFF888888)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                const Text(
                  '최근 검색 내역이 없습니다',
                  style: TextStyle(color: Color(0XFF9C9C9C)),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                const Divider(
                  color: Color(0XFFADADAD),
                ),
                const Text(
                  '닫기',
                  style: TextStyle(color: Color(0XFF9C9C9C)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

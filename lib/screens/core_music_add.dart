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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "내 음악 추가",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CoreMusicAddSelectScreen(),
                ),
              );
            },
            child: const Text(
              '확인',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: '곡, 앨범, 아티스트 명 등등의 텍스트',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 17 / 2 - 14,
                    horizontal: 10,
                  ),
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.clear,
                        color: Color(0xFFD8D8D8),
                      ),
                      Icon(
                        Icons.search,
                        color: Color(0xFF9C9C9C),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.height / 50),
                    ],
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              width: MediaQuery.of(context).size.height / 2.05,
              height: MediaQuery.of(context).size.height / 17,
            ),
          ],
        ),
      ),
    );
  }
}

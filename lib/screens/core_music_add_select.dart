import 'dart:async';

import 'package:dlive/screens/make_room_qr.dart';
import 'package:flutter/material.dart';

class CustomWidget extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const CustomWidget({
    required this.isChecked,
    required this.onChanged,
  });

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

//노래 single List
class _CustomWidgetState extends State<CustomWidget> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 300,
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.height / 30,
            ),
            Container(
              //이미지 들어갈 자리
              width: MediaQuery.of(context).size.height / 7,
              height: MediaQuery.of(context).size.height / 10.5,
              color: Colors.grey,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height / 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "노래 명",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "아티스트 명",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFAEAEAE),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height / 6,
            ),
            Container(
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isChecked ? Color(0xFFDE3B15) : Color(0XFFAEAEAE),
                  width: 1,
                ),
                color: _isChecked ? Color(0xFFDE3B15) : Colors.transparent,
              ),
              child: Checkbox(
                value: _isChecked,
                activeColor: Color(0xFFDE3B15),
                fillColor: MaterialStateProperty.all<Color>(Colors.transparent),
                checkColor: Colors.white,
                shape: CircleBorder(),
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                    widget.onChanged(value);
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 300,
        ),
        Divider(
          color: Color(0xFF707070),
          thickness: 0.5,
        ),
      ],
    );
  }
}

class CoreMusicAddSelectScreen extends StatefulWidget {
  const CoreMusicAddSelectScreen({Key? key}) : super(key: key);

  @override
  _CoreMusicAddSelectScreenState createState() =>
      _CoreMusicAddSelectScreenState();
}

class _CoreMusicAddSelectScreenState extends State<CoreMusicAddSelectScreen> {
  List<bool> isSelectedList = List.filled(10, false);
  List<bool> isOutlineVisibleList = List.filled(10, false);
  bool isCompleteButtonVisible = false;

  // 포기할 수 없는 3곡(밑에서 슝 올라오는거)
  void _showModalSheet(int index) {
    Timer(Duration(seconds: 2), () {
      Navigator.pop(context); // 모달 닫기
    });
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
          child: Container(
            height: 270,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '꼭 듣고 싶은 3곡을 골라주세요!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    3,
                    (innerIndex) => Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/Black_logo.png'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: isOutlineVisibleList[innerIndex]
                              ? Color(0xFFDE3B15)
                              : Color(0XFFD9D9D9),
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                if (index == 2)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/makeroomqr');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(280, 45),
                      primary: Color(0XFFCCCCCC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '완성!',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(
          'assets/background.jpg',
        ),
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                      vertical:
                          MediaQuery.of(context).size.height / 17 / 2 - 14,
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
                        SizedBox(
                            width: MediaQuery.of(context).size.height / 50),
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: isSelectedList.length,
                  itemBuilder: (context, index) {
                    return CustomWidget(
                      isChecked: isSelectedList[index],
                      onChanged: (value) {
                        if (value!) {
                          _showModalSheet(index);
                        }
                        setState(() {
                          isSelectedList = List.filled(10, false);
                          isSelectedList[index] = value;
                          // isOutlineVisibleList = List.filled(10, false);
                          isOutlineVisibleList[index] = value;

                          // 완성 버튼 표시 여부 확인
                          int selectedCount = 0;
                          for (int i = 0; i < isSelectedList.length; i++) {
                            if (isSelectedList[i]) {
                              selectedCount++;
                            }
                          }
                          isCompleteButtonVisible = selectedCount == 3;
                        });
                      },
                    );
                  },
                ),
              ),
              // if (isCompleteButtonVisible)
              //   ElevatedButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/makeroomqr');
              //     },
              //     style: ElevatedButton.styleFrom(
              //       fixedSize: const Size(280, 45),
              //       primary: Color(0XFFCCCCCC),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //     child: const Text(
              //       '완성!',
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

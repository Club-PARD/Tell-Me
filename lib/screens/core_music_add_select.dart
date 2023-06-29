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
              width: MediaQuery.of(context).size.height / 7.5,
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
                  "곡 제목",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "노래 | 가수 이름 | 노래 길이",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    color: Color(0xFFAEAEAE),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height / 20,
            ),
            Container(
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isChecked ? Colors.green : Colors.grey,
                  width: 1,
                ),
                color: _isChecked ? Colors.green : Colors.transparent,
              ),
              child: Checkbox(
                value: _isChecked,
                activeColor: Colors.green,
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

  //포기할 수 없는 3곡(밑에서 슝 올라오는거)
  void _showModalSheet(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 270,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '포기할 수 없는 3곡을 골라주세요!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
                      color: isOutlineVisibleList[innerIndex]
                          ? Color(0XFFD9D9D9)
                          : Color(0XFFD9D9D9),
                      border: Border.all(
                        color: isOutlineVisibleList[innerIndex]
                            ? Colors.green
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
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/MakeRoomQrScreen');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(280, 45),
                    primary: Color(0XFFCCCCCC),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // 원하는 radius 값으로 조정
                    ),
                  ),
                  child: const Text(
                    '완성!',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "내 코어 음악 추가",
          style: TextStyle(
            color: Colors.white,
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
                  fillColor: Colors.grey.shade700,
                  hintText: '  가수 이름',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 17 / 2 - 14,
                    horizontal: 10,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              width: MediaQuery.of(context).size.height / 2.2,
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
                        //isOutlineVisibleList = List.filled(10, false);
                        isOutlineVisibleList[index] = value;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

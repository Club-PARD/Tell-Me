import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:dlive/utils/room_util.dart';

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

    final roomProvider = Provider.of<RoomProvider>(context);

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
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
              size: 32,
            ),
          ),
          title: const Text(
            '스테이션 정보 설정',
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  roomProvider.setName(_textEditingController.text);
                  Navigator.pushNamed(context, '/makeroomexplain');
                },
                child: const Text(
                  '확인',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 812 * 28,
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Image.asset(
                            height: height / 812 * 106,
                            width: width / 375 * 106,
                            roomProvider.img,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: height / 812 * 76,
                          left: width / 375 * 82,
                          child: GestureDetector(
                            onTap: () {
                              _showDialog(context);
                            },
                            child: Image.asset(
                              'assets/images/camera.png',
                              width: width / 375 * 30,
                              height: height / 812 * 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.005),
                    GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: TextField(
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          hintText: '방 이름을 적어주세요',
                          hintStyle: TextStyle(color: Color(0XFF9C9C9C)),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 812 * 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          '음악 재생전, 내가 설정한 그룹청취방의 사진과 이름은\n 다른 모든 멤버에게도 동일하게 보입니다.',
                          style: TextStyle(color: Color(0XFF9C9C9C)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> _showDialog(BuildContext context) {
  final roomProvider = Provider.of<RoomProvider>(context, listen: false);
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            actions: [
              Center(
                child: Column(
                  children: [
                    const Text(
                      '대표 사진 설정',
                      style: TextStyle(color: Color(0XFF383838)),
                    ),
                    TextButton(
                        onPressed: () async {
                          var picker = ImagePicker();
                          var image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            roomProvider.setImg(image.path);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text(
                          '앨범에서 사진/동영상 선택',
                          style: TextStyle(color: Color(0XFF383838)),
                        )),
                    TextButton(
                        onPressed: () {
                          roomProvider.setImg('assets/room_default_color.png');
                          Navigator.pop(context);
                        },
                        child: const Text(
                          '기본 이미지로 변경',
                          style: TextStyle(color: Color(0XFF383838)),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
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

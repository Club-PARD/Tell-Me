import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:dlive/utils/room_util.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

const defaultImgUrl =
    'https://firebasestorage.googleapis.com/v0/b/pard-dlive-b27d9.appspot.com/o/room_img%2Froom_default_color.png?alt=media&token=22258b36-f315-4bc5-b159-f7e73f98baba';

class MakeRoom extends StatefulWidget {
  const MakeRoom({Key? key}) : super(key: key);

  @override
  _MakeRoomState createState() => _MakeRoomState();
}

class _MakeRoomState extends State<MakeRoom> {
  final TextEditingController _textEditingController = TextEditingController();
  late String roomId = '';

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
            onPressed: () async {
              final currentImgUrl = roomProvider.img;

              if (currentImgUrl != defaultImgUrl) {
                // 이미지가 존재하는지 확인
                var previousImageRef =
                    FirebaseStorage.instance.refFromURL(currentImgUrl);
                await previousImageRef.delete();
              }

              roomProvider.setImg(defaultImgUrl);
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
                  if (_textEditingController.text.isNotEmpty) {
                    roomProvider.setName(_textEditingController.text);
                    _generateRandomRoomId(); // 무작위 roomId 생성
                    roomProvider.setId(roomId); // setid()를 사용하여 roomId 저장
                    Navigator.pushNamed(context, '/makeroomexplain');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('공습경보!!! 방 이름을 적어주세요!')),
                    );
                  }
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
                    GestureDetector(
                      onTap: () {
                        _showDialog(context);
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Image.network(
                              roomProvider.img,
                              height: height / 812 * 106,
                              width: width / 375 * 106,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: height / 812 * 76,
                            left: width / 375 * 82,
                            child: Image.asset(
                              'assets/images/camera.png',
                              width: width / 375 * 30,
                              height: height / 812 * 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: TextField(
                        onSubmitted: (value) {
                          if (_textEditingController.text.isNotEmpty) {
                            roomProvider.setName(_textEditingController.text);
                            _generateRandomRoomId(); // 무작위 roomId 생성
                            roomProvider
                                .setId(roomId); // setid()를 사용하여 roomId 저장
                            Navigator.pushNamed(context, '/makeroomexplain');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('공습경보!!! 방 이름을 적어주세요!')),
                            );
                          }
                        },
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
                    var image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      // Delete previous image if it exists
                      // if (roomProvider.img != defaultImgUrl) {
                      //   var previousImageRef = FirebaseStorage.instance
                      //       .refFromURL(roomProvider.img);
                      //   await previousImageRef.delete();
                      //   print('이전 사진 삭제');
                      // }

                      print('삭제할 사진 없음');
                      var file = File(image.path);
                      var fileName = basename(file.path);
                      var uploadTask = FirebaseStorage.instance
                          .ref('room_img')
                          .child(fileName)
                          .putFile(file);

                      await uploadTask.whenComplete(() async {
                        var downloadUrl =
                            await uploadTask.snapshot.ref.getDownloadURL();
                        roomProvider.setImg(downloadUrl);
                      });
                      print(roomProvider.img);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    '앨범에서 사진/동영상 선택',
                    style: TextStyle(color: Color(0XFF383838)),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // Delete previous image if it exists
                    // var previousImageRef =
                    //     FirebaseStorage.instance.refFromURL(roomProvider.img);
                    // await previousImageRef.delete();
                    // print('이전 사진 삭제');

                    print(roomProvider.img);
                    roomProvider.setImg(defaultImgUrl);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '기본 이미지로 변경',
                    style: TextStyle(color: Color(0XFF383838)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '취소',
                    style: TextStyle(color: Color(0XFF383838)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _generateRandomRoomId() {
    final random = Random();
    final roomIdLength = 6; // Length of the generated roomId
    final alphanumericChars =
        '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final codeUnits = alphanumericChars.codeUnits;

    roomId = String.fromCharCodes(
      List.generate(
        roomIdLength,
        (_) => codeUnits[random.nextInt(codeUnits.length)],
      ),
    );
  }
}

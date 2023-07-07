import 'package:dlive/utils/host_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:flutter/services.dart';
import '../utils/room_util.dart';

class MakeRoomQrScreen extends StatefulWidget {
  const MakeRoomQrScreen({Key? key}) : super(key: key);

  @override
  _MakeRoomQrScreenState createState() => _MakeRoomQrScreenState();
}

class _MakeRoomQrScreenState extends State<MakeRoomQrScreen> {
  bool isCopied = false;

  void _showCopiedMessage() {
    setState(() {
      isCopied = true;
    });
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Container(
    //       height: MediaQuery.of(context).size.height / 812 * 23,
    //       width: MediaQuery.of(context).size.width / 375 * 290,
    //       //color: Colors.black.withOpacity(0.5), // 투명도가 있는 검은색 배경
    //       child: Center(
    //         child: Text(
    //           '복사 완료!',
    //           style: TextStyle(
    //             fontSize: 16.0,
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //     ),
    //     duration: Duration(milliseconds: 500),
    //     behavior: SnackBarBehavior.floating,
    //   ),
    // );
    Fluttertoast.showToast(
      msg: '복사 완료!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    HostProvider hostProvider = Provider.of<HostProvider>(context);
    RoomProvider roomProvider = Provider.of<RoomProvider>(context);
    HostUtil hostUtil = HostUtil();
    RoomUtil roomUtil = RoomUtil();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/coremusicadd'));
            Navigator.pushNamed(context, '/coremusicadd');
          },
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        title: const Text(
          '내 QR 코드',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              print(roomProvider.img);
              // roomUtil.addRoom(
              //   roomProvider.name,
              //   roomProvider.id,
              //   roomProvider.img,
              //   roomProvider.url,
              //   roomProvider.playlist,
              //   [hostProvider.name],
              // );
              Navigator.pushNamed(context, '/stationloading');
            },
            child: const Text(
              '확인',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 36,
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  hostUtil.getQr(hostProvider.character),
                  height: MediaQuery.of(context).size.height / 812 * 512,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 812 * 200,
                  left: 0,
                  right: 0,
                  child: Text(
                    '@${roomProvider.name}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 812 * 250,
                  child: PrettyQr(
                    image: const AssetImage('assets/logo_image.png'),
                    typeNumber: 3,
                    size: MediaQuery.of(context).size.height / 812 * 230,
                    data: '${roomProvider.id}',
                    errorCorrectLevel: QrErrorCorrectLevel.M,
                    roundEdges: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 56,
          ),
          ElevatedButton(
            onPressed: () {
              String textToCopy = roomProvider.id;
              Clipboard.setData(ClipboardData(text: textToCopy));
              _showCopiedMessage();
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(
                MediaQuery.of(context).size.width / 375 * 146,
                MediaQuery.of(context).size.height / 812 * 61,
              ),
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 12, // 그림자 크기 조절
              shadowColor: Colors.black.withOpacity(0.8), // 그림자 색상
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ph_link.png',
                  width: 20, // 이미지의 크기 조정
                ),
                const SizedBox(width: 8), // 이미지와 텍스트 사이의 간격 조정
                const Text(
                  '초대 코드 복사',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF438BC3),
                    fontWeight: (FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

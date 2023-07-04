import 'package:dlive/utils/host_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hostProvider = Provider.of<HostProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
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
          "프로필 편집",
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
              Navigator.pushNamed(context, '/home');
            },
            child: const Text(
              '완료',
              style: TextStyle(
                color: Color(0xFF50A7EB),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 23,
        ),
        Image.asset(
          'assets/profile_pink.png',
          height: MediaQuery.of(context).size.height / 812 * 116,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 14,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/profilecharacter');
          },
          child: Text(
            "캐릭터 변경하기",
            style: TextStyle(
              color: Color(0xFF50A7EB),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 27,
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 375 * 35,
            ),
            Text(
              "사용자 이름",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 375 * 45,
            ),
            Text(
              '${hostProvider.name}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/profilename',
                );
              },
              child: Image.asset(
                'assets/pencil_icon.png',
                height: MediaQuery.of(context).size.height / 812 * 20,
              ),
            )
          ],
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tell_me_mypage/view/profile_page.dart';

class signUpCharacterPage extends StatelessWidget {
  const signUpCharacterPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('내 뮤디 설정'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => signUpCharacterPage(),
                    ),
                    // Navigator.pushNamed(context, 'profile'),
                  );
                },
                child: const Text('<닉네임>'),
              ),
            ],
          ),
        ));
  }
}

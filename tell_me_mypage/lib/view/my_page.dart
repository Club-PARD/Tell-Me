import 'package:flutter/material.dart';
import 'package:tell_me_mypage/view/profile_page.dart';

class myPage extends StatelessWidget {
  const myPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('My Page')),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),

              //add profile image

              //profile_page button
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => profilePage(),
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

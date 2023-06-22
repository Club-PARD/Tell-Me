import 'package:flutter/material.dart';

class profilePage extends StatelessWidget {
  const profilePage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('edit profile')),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),

              //add profile image

              //닉네임 수정
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '<현재 닉네임>',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              //자기소개 키워드 수정
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '<현재 자기소개>',
                ),
              ),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('변경하기'),
              ),
            ],
          ),
        ));
  }
}

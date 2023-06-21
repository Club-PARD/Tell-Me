import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/2,),
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('signup')
          ),
        ]
        ),
    );
  }
}
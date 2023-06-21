import 'package:flutter/material.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => __WriteScreenState();
}

class __WriteScreenState extends State<WriteScreen> {
final TextEditingController _editCon = TextEditingController();

  @override
  void initState() {
    super.initState();
  _editCon.addListener(() {});
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _editCon.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    String inputText='';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      title: const Text('Youtube'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _editCon,
                decoration: const InputDecoration(
                  hintText: 'url을 입력해주세요',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: () { Navigator.pushNamed(context, '/home',arguments: inputText,);},
               child: const Text('Search')),
            ],
          ),
        ),
      )
    );
  }
}
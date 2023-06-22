import 'package:flutter/material.dart';
import 'package:youtube_parser/youtube_parser.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => __WriteScreenState();
}

class __WriteScreenState extends State<WriteScreen> {
final TextEditingController _editCon = TextEditingController();
String? url;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _editCon,
                  decoration: const InputDecoration(
                    hintText: 'url을 입력해주세요',
                  ),
                  keyboardType: TextInputType.text,
                ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      inputText = _editCon.text;
                     String? url=getIdFromUrl(_editCon.text);    //parsing성공, 누르면 파싱한 값 61번 줄의 argument로 보내고 싶은데 elevatedButton밖에서 값을 사용하지 못함
                    });
                  },
                  child: const Text('Enter'),
                ),
                Text('$url'),
                const Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                  onPressed: () { Navigator.pushNamed(context, '/home',arguments: url,);},
                 child: const Text('Search')),
              ],
            ),
          ),
        ),
      )
    );
  }
}
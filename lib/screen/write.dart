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
                     url=getIdFromUrl(_editCon.text);
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
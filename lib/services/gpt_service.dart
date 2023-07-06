import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GptService {
  static String? apiKey = dotenv.env['OPENAI_API_KEY'];

// class MyApp extends StatelessWidget {
//   MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     OpenAI.apiKey = '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';
//     int time = 60; //min
//     String numOfSongs = (time/3).toString();

//     List<List<String>> selections = [
//     ['지코 - Artist', '호미들 - 사이렌', '창모 - METHEO'],
//     ['아이유 - 팔레트', '폴킴 - 모든 날 모든 순간', ''],
//     ['김동률 - 감사', '', ''],
//     ['닐로 - 지나오다', '양다일 - 미안해', ''],
//     ['', '', ''],
//     ['', '', ''],
//   ];

//     return Directionality(
//       textDirection:
//           TextDirection.ltr, // Provide the appropriate reading direction here
//       child: MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(
//             title: Text('gpt test'),
//           ),
//           body: Column(
//             children: [
//               Expanded(child: showPlaylist(selections)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//페이지에 출력

// Widget showPlaylist(List<List<String>> selections, String numOfSongs) {
//   return FutureBuilder<List<List<String>>>(
//     future: songs(selections,generateText(selections)),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasError) {
//         return Text('Error: ${snapshot.error}');
//       } else {
//         return Text('${snapshot.data}');
//       }
//     },
//   );
// }

//print로 출력
  Widget showPlaylist(List<List<String>> selections, String numOfSongs) {
    return FutureBuilder<List<List<String>>>(
      future: songs(selections, generateText(selections, numOfSongs)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          print(snapshot.data);
          return const SizedBox(); // Placeholder widget
        }
      },
    );
  }

  Future<String> generateText(
      List<List<String>> selections, String numOfSongs) async {
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(model: "gpt-3.5-turbo", messages: [
      OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.system,
        content:
            'You are a music playlist creation model that helps each person get a fair shot at listening to their favorite genres of music.',
      ),
      OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.user,
        content:
            '${selections[0][0]}\n${selections[1][0]}\n${selections[2][0]}\n${selections[3][0]}\n${selections[4][0]}\n${selections[5][0]}\n${selections[0][1]}\n${selections[1][1]}\n${selections[2][1]}\n${selections[3][1]}\n${selections[4][1]}\n${selections[5][1]}\n${selections[0][2]}\n${selections[1][2]}\n${selections[2][2]}\n${selections[3][2]}\n${selections[4][2]}\n${selections[5][2]}\n\nAdd all the songs in the playlist in this order, except for the song with the value "", and then add more songs of the same genre in the same order to create a playlist of {$numOfSongs} songs (Never print any other text, just the playlist).\n\nEach song is output in the following format: <singer> - <title>',
      ),
    ]);
    return chatCompletion.choices.first.message.content;
  }

  Future<List<List<String>>> songs(
      List<List<String>> selections, Future<String> futureRecommand) async {
    String recommand = await futureRecommand;
    List<String> playList = recommand
        .split('\n')
        .map((song) => song.substring(song.indexOf('.') + 1))
        .toList();
    List<List<String>> songs = List.generate(
        playList.length, (index) => playList[index].split(' - ').toList());
    return songs;
  } //이게 배열 결과 함수임
}

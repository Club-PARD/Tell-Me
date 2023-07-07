import 'dart:convert';

import 'package:dlive/models/meta_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:youtube_parser/youtube_parser.dart';
import 'package:http/http.dart' as http;

class getTitle {
  final String? apiKey = dotenv.env['YOUTUBE_API_KEY11'];

  Future<List<YoutubeTitle>> fetchTitle(String videoUrl) async {
    final String? videoId = getIdFromUrl(videoUrl);

    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$videoId&key=$apiKey'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<dynamic> videoJson = jsonResponse['items'];

      List<YoutubeTitle> videos = videoJson
          .map((json) => YoutubeTitle.fromMap(json['snippet']))
          .toList();
      print(videos);
      return videos;
      // final title = jsonResponse['items'][0]['snippet']['title'];
      // titles.add(title);
      // print(titles);
    } else {
      throw Exception('Failed to fetch video title');
    }
  }
}

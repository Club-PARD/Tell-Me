import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dlive/models/youtube_video_model.dart';

class ApiService {
  final String? apiKey = dotenv.env['YOUTUBE_API_KEY2'];

  // 검색어를 받아와서 비디오를 로드
  Future<List<YoutubeVideo>> fetchVideos(String query) async {
    final response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&order=viewCount&videoEmbeddable=true&videoSyndicated=true&q=$query&type=video&key=$apiKey'),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> videosJson = data['items'];

      // 각 비디오를 YoutubeVideo 클래스에 매핑
      List<YoutubeVideo> videos = videosJson
          .map((json) =>
              YoutubeVideo.fromMap(json['snippet'], json['id']['videoId']))
          .toList();

      return videos;
    } else {
      throw Exception('비디오를 로드하는 데 실패했습니다.');
    }
  }

  // 검색어 리스트를 받아와서 영상 리스트로 반환
  Future<List<YoutubeVideo>> fetchTopViewedVideos(
      List<List<String>> songs) async {
    List<YoutubeVideo> videos = [];

    for (List<String> song in songs) {
      // song[0]은 아티스트 이름, song[1]은 노래 제목
      String query = '${song[0]} ${song[1]}';
      final response = await http.get(Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&order=viewCount&q=$query&type=video&key=$apiKey'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var video = YoutubeVideo.fromMap(
            data['items'][0]['snippet'], data['items'][0]['id']['videoId']);
        videos.add(video);
        print(video.id); // 비디오 ID를 콘솔에 출력
      } else {
        throw Exception('Failed to load videos');
      }
    }

    return videos;
  }

  // 검색어 리스트를 받아와서 ID 리스트로 반환
  // Future<List<String>> fetchTopViewedVideoIds(List<List<String>> songs) async {
  //   List<String> videoIds = [];

  //   for (List<String> song in songs) {
  //     // song[0]은 아티스트 이름, song[1]은 노래 제목
  //     String query = '${song[0]} ${song[1]}';
  //     final response = await http.get(Uri.parse(
  //         'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&order=viewCount&q=$query&type=video&key=$apiKey'));

  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body);
  //       var videoId = data['items'][0]['id']['videoId'];
  //       videoIds.add(videoId);
  //     } else {
  //       throw Exception('Failed to load videos');
  //     }
  //   }
  //   print(videoIds);

  //   return videoIds;
  // }
}

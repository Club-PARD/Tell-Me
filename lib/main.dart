import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'test/api_service.dart';
import 'test/youtube_video.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _queryController.addListener(_onQueryChanged);
    _fetchVideos();
  }

  void _onQueryChanged() {
    setState(() {
      query = _queryController.text;
    });
  }

  void _fetchVideos() {
    _apiService.fetchTopViewedVideos(songs).then((fetchedVideos) {
      setState(() {
        videos = fetchedVideos;
      });
    });
  }

  ApiService _apiService = ApiService();
  String query = "";
  List<YoutubeVideo> videos = [];
  List<String> videoIds = [];
  List<List<String>> songs = [
    ["지코", "Artist"],
    ["아이유", "팔레트"],
    ["김동률", "감사"],
    ["닐로", "지나오다"],
    ["호미들", "사이렌"],
    ["폴킴", "모든 날 모든 순간"]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube 검색'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _queryController,
              onChanged: (value) {
                _onQueryChanged();
                // 실시간으로 연관 검색어 사용
                // _apiService.fetchVideos(value).then((videos) {
                //   setState(() {
                //     this.videos = videos;
                //   });
                // });
              },
              decoration: InputDecoration(
                labelText: "검색",
                hintText: "비디오 검색",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
              ),
            ),
          ),
          // 연관 검색어 사용
          // if (videos != null && query.isNotEmpty)
          //   Container(
          //     height: 200,
          //     child: RelatedSearchList(
          //         videos: videos.take(5).toList(), query: query),
          //   ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 검색어 검색
              ElevatedButton(
                onPressed: () {
                  if (query.isNotEmpty) {
                    _apiService.fetchVideos(query).then((videos) {
                      setState(() {
                        this.videos = videos;
                      });
                    });
                  }
                },
                child: Text('검색'),
              ),
              // 검색 리스트 검색
              ElevatedButton(
                onPressed: () {
                  if (songs.isNotEmpty) {
                    _apiService
                        .fetchTopViewedVideoIds(songs)
                        .then((fetchedVideoIds) {
                      setState(() {
                        videoIds = fetchedVideoIds;
                      });
                      print(
                          videoIds); // 이제 videoIds는 클래스의 멤버 변수이므로 필요한 곳에서 사용할 수 있습니다.
                      _fetchVideos();
                    });
                  }
                },
                child: Text('리스트 검색'),
              ),
            ],
          ),
          Expanded(
            child: videos.isEmpty
                ? Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 50.0,
                    ),
                  )
                : ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(videos[index].thumbnailUrl),
                        title: Text(videos[index].title),
                        onTap: () => launch(
                            'https://www.youtube.com/watch?v=${videos[index].id}'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// 연관 검색어
class RelatedSearchList extends StatelessWidget {
  final List<YoutubeVideo> videos;
  final String query;

  RelatedSearchList({required this.videos, required this.query});

  @override
  Widget build(BuildContext context) {
    // 비디오 타이틀에서 단어를 추출하여 하나의 리스트 생성
    List<String> keywords = [];
    for (var video in videos) {
      keywords.addAll(video.getKeywords());
    }

    // 현재 검색어를 포함하거나, 현재 검색어와 유사한 단어들을 연관 검색어로 선택
    List<String> relatedSearches =
        keywords.where((keyword) => keyword.contains(query)).toList();

    return ListView.builder(
      itemCount: relatedSearches.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(relatedSearches[index]),
        );
      },
    );
  }
}

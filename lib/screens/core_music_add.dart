import 'package:dlive/models/youtube_video_model.dart';
import 'package:dlive/screens/core_music_add_select.dart';
import 'package:dlive/services/youtube_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CoreMusicAdd extends StatefulWidget {
  const CoreMusicAdd({Key? key}) : super(key: key);

  @override
  State<CoreMusicAdd> createState() => _CoreMusicAddState();
}

class _CoreMusicAddState extends State<CoreMusicAdd> {
  final TextEditingController _queryController = TextEditingController();
  ApiService _apiService = ApiService();
  String query = "";
  List<YoutubeVideo> videos = [];
  List<String> videoIds = [];
  List<List<String>> songs = [];
  // List<List<String>> songs = [
  //   ["지코", "Artist"],
  //   ["아이유", "팔레트"],
  //   ["김동률", "감사"],
  //   ["닐로", "지나오다"],
  //   ["호미들", "사이렌"],
  //   ["폴킴", "모든 날 모든 순간"]
  // ];

  @override
  void initState() {
    super.initState();
    _queryController.addListener(_onQueryChanged);
    _fetchVideos();
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "내 음악 추가",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CoreMusicAddSelectScreen(),
                ),
              );
            },
            child: const Text(
              '확인',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height / 2.05,
              height: MediaQuery.of(context).size.height / 17,
              child: TextField(
                controller: _queryController,
                onChanged: (value) {
                  _onQueryChanged();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: '곡, 앨범, 아티스트 명 등등의 텍스트',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 17 / 2 - 14,
                    horizontal: 10,
                  ),
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Color(0xFFD8D8D8),
                        ),
                        onPressed: () {
                          _queryController.clear();
                          _onQueryChanged();
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Color(0xFF9C9C9C),
                        ),
                        onPressed: () {
                          if (query.isNotEmpty) {
                            _apiService.fetchVideos(query).then((videos) {
                              setState(() {
                                this.videos = videos;
                              });
                            });
                          }
                        },
                      ),
                      SizedBox(width: MediaQuery.of(context).size.height / 50),
                    ],
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
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
                          onTap: () {},
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

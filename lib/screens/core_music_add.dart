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
  final ApiService _apiService = ApiService();
  String query = "";
  List<YoutubeVideo> videos = [];
  List<String> videoIds = [];
  List<List<String>> songs = [];
  Map<String, bool> videoIdSelections = {}; //각 videoId의 선택 상태를 저장하는 맵 추가

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
    fetchAndDisplayVideos();
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

  void fetchAndDisplayVideos() {
    if (songs.isNotEmpty) {
      _apiService.fetchTopViewedVideoIds(songs).then((fetchedVideoIds) {
        setState(() {
          videoIds = fetchedVideoIds;
          // 새로운 videoId들을 가져와서 선택 상태 맵을 초기화합니다.
          videoIdSelections = Map.fromIterable(fetchedVideoIds,
              key: (item) => item, value: (item) => false);
        });
        print(videoIds);
        _fetchVideos();
      });
    }
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
          icon: const Icon(
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
                  builder: (context) => const CoreMusicAddSelectScreen(),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
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
                    hintStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical:
                          MediaQuery.of(context).size.height / 17 / 2 - 14,
                      horizontal: 10,
                    ),
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                        SizedBox(
                            width: MediaQuery.of(context).size.height / 50),
                      ],
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                child: videos.isEmpty
                    ? const Center(
                        child: SpinKitCircle(
                          color: Color(0xFFDE3B15),
                          size: 50.0,
                        ),
                      )
                    : ListView(
                        children: videoIds.map((videoId) {
                          return CheckboxListTile(
                            title: Text(videoId),
                            value: videoIdSelections[videoId],
                            onChanged: (bool? newValue) {
                              setState(() {
                                videoIdSelections[videoId] = newValue!;
                              });
                            },
                          );
                        }).toList(),
                      ),
                // ListView.builder(
                //     itemCount: videos.length,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         leading: Image.network(videos[index].thumbnailUrl),
                //         title: Text(videos[index].title),
                //         onTap: () {},
                //       );
                //     },
                //   ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomWidget extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const CustomWidget({
    required this.isChecked,
    required this.onChanged,
  });

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

//노래 single List
class _CustomWidgetState extends State<CustomWidget> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 300,
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.height / 30,
            ),
            Container(
              //이미지 들어갈 자리
              width: MediaQuery.of(context).size.height / 7,
              height: MediaQuery.of(context).size.height / 10.5,
              color: Colors.grey,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height / 40,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "노래 명",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "아티스트 명",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFAEAEAE),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height / 23,
            ),
            Container(
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isChecked ? Color(0xFFDE3B15) : Color(0XFFAEAEAE),
                  width: 1,
                ),
                color: _isChecked ? Color(0xFFDE3B15) : Colors.transparent,
              ),
              child: Checkbox(
                value: _isChecked,
                activeColor: Color(0xFFDE3B15),
                fillColor: MaterialStateProperty.all<Color>(Colors.transparent),
                checkColor: Colors.white,
                shape: CircleBorder(),
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                    widget.onChanged(value);
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 300,
        ),
        Divider(
          color: Color(0xFF707070),
          thickness: 0.5,
        ),
      ],
    );
  }
}

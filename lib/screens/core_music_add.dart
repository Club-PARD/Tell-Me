import 'dart:async';

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
  bool _isChecked = false;
  String query = "";
  List<YoutubeVideo> videos = [];
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

  // void _fetchVideos() {
  //   _apiService.fetchTopViewedVideos(songs).then((fetchedVideos) {
  //     setState(() {
  //       videos = fetchedVideos;
  //     });
  //   });
  // }
  void _fetchVideos() {
    _apiService.fetchTopViewedVideos(songs).then((fetchedVideos) {
      setState(() {
        videos = fetchedVideos;
        videoIdSelections = Map.fromIterable(
          videos,
          key: (video) => (video as YoutubeVideo).title,
          value: (video) => false,
        );
      });
    });
  }

  void _searchVideos(String query) {
    if (query.isNotEmpty) {
      _apiService.fetchVideos(query).then((videos) {
        setState(() {
          this.videos = videos;
          videoIdSelections = Map.fromIterable(
            videos,
            key: (video) => (video as YoutubeVideo).title,
            value: (video) => false,
          );
        });
      });
    }
  }

  // 포기할 수 없는 3곡(밑에서 슝 올라오는거)
  void _showModalSheet(int index) {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pop(context); // 모달 닫기
    });
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(50.0)),
          child: Container(
            height: 270,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '꼭 듣고 싶은 3곡을 골라주세요!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    3,
                    (index) => Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: videoIdSelections[videos[index].title] ?? false
                              ? const Color(0xFFDE3B15)
                              : const Color(0XFFD9D9D9),
                          width: 4,
                        ),
                      ),
                      child: ClipOval(
                        child: (videoIdSelections[videos[index].title] ?? false)
                            ? Image.network(
                                videos[index].thumbnailUrl,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/Black_logo.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                if (index == 2)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/makeroomwaiting');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(249, 46),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '완성!',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 40,
              ),
              width: MediaQuery.of(context).size.height / 2.05,
              height: MediaQuery.of(context).size.height / 17,
              child: TextField(
                controller: _queryController,
                onSubmitted: (value) {
                  // if (query.isNotEmpty) {
                  //   _apiService.fetchVideos(query).then((videos) {
                  //     setState(() {
                  //       this.videos = videos;
                  //     });
                  //   });
                  // }
                  // _fetchVideos();
                  _searchVideos(query);
                },
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
                    vertical: MediaQuery.of(context).size.height / 17 / 2 - 14,
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
                          // if (query.isNotEmpty) {
                          //   _apiService.fetchVideos(query).then((videos) {
                          //     setState(() {
                          //       this.videos = videos;
                          //     });
                          //   });
                          // }
                          // _fetchVideos();
                          _searchVideos(query);
                        },
                      ),
                      SizedBox(width: MediaQuery.of(context).size.height / 50),
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
                  : ListView.separated(
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              // 현재 선택된 항목 수를 계산합니다.
                              int currentSelectedCount = videoIdSelections
                                  .values
                                  .where((v) => v)
                                  .length;

                              // 만약 3개 미만이라면, 현재 항목의 선택 상태를 토글합니다.
                              if (currentSelectedCount < 3 ||
                                  videoIdSelections[videos[index].title] ==
                                      true) {
                                videoIdSelections[videos[index].title] =
                                    !(videoIdSelections[videos[index].title] ??
                                        false);
                                _showModalSheet(index);
                              } else {
                                // 이미 3개가 선택되어 있다면, 경고 메시지를 표시합니다.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'You can only select up to 3 videos.')),
                                );
                              }

                              print("Updated value: ${videos[index].title}");
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height / 100),
                            child: ListTile(
                              dense: true,
                              visualDensity: const VisualDensity(vertical: 3),
                              leading: SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.height / 8,
                                child: Image.network(
                                  videos[index].thumbnailUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(videos[index].title),
                              trailing: Transform.scale(
                                scale: 1.1,
                                child: Checkbox(
                                  onChanged: (value) {
                                    setState(() {
                                      // 현재 선택된 항목 수를 계산합니다.
                                      int currentSelectedCount =
                                          videoIdSelections.values
                                              .where((v) => v)
                                              .length;

                                      // 만약 3개 미만이라면, 현재 항목의 선택 상태를 토글합니다.
                                      if (currentSelectedCount < 3 ||
                                          videoIdSelections[
                                                  videos[index].title] ==
                                              true) {
                                        videoIdSelections[videos[index].title] =
                                            !(videoIdSelections[
                                                    videos[index].title] ??
                                                false);
                                        _showModalSheet(index);
                                      } else {
                                        // 이미 3개가 선택되어 있다면, 경고 메시지를 표시합니다.
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'You can only select up to 3 videos.')),
                                        );
                                      }
                                    });
                                  },
                                  value:
                                      videoIdSelections[videos[index].title] ??
                                          false,
                                  activeColor: const Color(0xFFDE3B15),
                                  shape: const CircleBorder(
                                      side: BorderSide(
                                          color: Color(0xFFAEAEAE),
                                          width: 0.5)),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: Color(0xFF707070),
                          thickness: 0.5,
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

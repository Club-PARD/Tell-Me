import 'dart:convert';
import 'package:dlive/services/youtube_service.dart';
import 'package:dlive/utils/playlist_util.dart';
import 'package:dlive/utils/room_util.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dlive/screens/playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StationMain extends StatefulWidget {
  const StationMain({super.key});
  @override
  State<StationMain> createState() => _StationMainState();
}

class _StationMainState extends State<StationMain> {
  List<String> videoUrl = [];
  late List<String> videoIds = [];
  late List<String> titles = [];
  late List<String> artist = [];
  List<String> thumbNail = [];
  PlaylistUtil playlistUtil = PlaylistUtil();

  late List<YoutubePlayerController> controllers;
  @override
  void initState() {
    super.initState();
    _fetchTopViewedVideos();
    parseVideoUrls();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _fetchTopViewedVideos() async {
    RoomProvider roomProvider =
        Provider.of<RoomProvider>(context, listen: false);

    String? playlistId =
        await playlistUtil.getPlaylistIdFromRoom(roomProvider.id);
    List<List<String>> songs = await playlistUtil.getSongs(playlistId!);

    if (songs != null && songs.isNotEmpty) {
      ApiService apiService = ApiService();
      List<String> videoIds = await apiService.fetchTopViewedVideoIds(songs);
      setState(() {
        videoUrl = videoIds;
      });
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@$videoUrl");
    }
  }

  Future<List<String>> fetchMetaData() async {
    //List<String> titles의 값
    await Future.delayed(const Duration(seconds: 2), () {});
    return await getMetaData();
  }

  Future<void> parseVideoUrls() async {
    for (String url in videoUrl) {
      //  final String? videoId = getIdFromUrl(url);
      //  videoIds.add(videoId!);
      final controller = YoutubePlayerController(
        initialVideoId: url,
        flags: const YoutubePlayerFlags(autoPlay: false),
      );
      controllers.add(controller);
    }
    setState(() {});
  }

  Future<List<String>> getMetaData() async {
    final String? apiKey = dotenv.env['YOUTUBE_API_KEY2'];

    for (String url in videoUrl) {
      //  final String? videoId = getIdFromUrl(url);
      thumbNail.add('https://img.youtube.com/vi/$url/0.jpg');
      final response = await http.get(Uri.parse(
          'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$url&key=$apiKey'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final title = jsonResponse['items'][0]['snippet']['title'];
        titles.add(title);
      } else {
        throw Exception('Failed to fetch video title');
      }
    }
    return titles;
  }

  void removeFromPlaylist(int index) {
    videoUrl.removeAt(index);
    videoIds.removeAt(index);
    thumbNail.removeAt(index);
    titles.removeAt(index);
    artist.removeAt(index);
    controllers[index].dispose();
    controllers.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    DateTime now = DateTime.now();
    String formatDate = DateFormat('yyyy-MM-dd').format(now);
    RoomProvider roomProvider = Provider.of<RoomProvider>(context);
    // RoomProvider roomProvider =
    //     Provider.of<RoomProvider>(context, listen: false);
    // RoomUtil roomUtil = RoomUtil();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          '방이름',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/navigation'));
            },
            icon: const Icon(Icons.home, color: Colors.black),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Container(
                width: width / 3,
                height: height / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset('assets/room_default_black.png'),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    '참여자',
                    style: TextStyle(color: Color(0XFF929292)),
                  ),
                  const Text(
                    '멜로디언',
                    style: TextStyle(),
                  ),
                  SizedBox(
                    height: height / 15,
                  ),
                  Text(formatDate),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaylistScreen(
                        videoUrl: videoIds,
                        initialIndex: 0,
                        count: videoUrl.length,
                        songTitle: titles,
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  minimumSize: MaterialStateProperty.all(
                    Size(width * 2 / 5, height / 18),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      '모두재생',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    videoUrl.clear();
                    videoIds.clear();
                    titles.clear();
                    artist.clear();
                    thumbNail.clear();
                    for (var controller in controllers) {
                      controller.dispose();
                    }
                    controllers.clear();
                  });
                  parseVideoUrls();
                  getMetaData();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xFF438BC3),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(width * 2 / 5, height / 18),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.change_circle_outlined),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '다시생성',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: fetchMetaData(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Image.asset('assets/car_moving_final.gif'),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('FutureBuilder에 값 없음'),
                  );
                } else {
                  final count = snapshot.data!.length;
                  return ListView.builder(
                    itemCount: count,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaylistScreen(
                                videoUrl: videoIds,
                                initialIndex: index,
                                count: count,
                                songTitle: titles,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: width,
                          height: height / 8,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.menu),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: width / 3,
                                height: height / 9,
                                child: CachedNetworkImage(
                                  imageUrl: thumbNail[index],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data![index]
                                      .split('-')
                                      .join('\n')
                                      .replaceAllMapped(
                                          RegExp(
                                              r'\([^()]*\)|\[[^\[\]]*\]|\|,'),
                                          (match) => ''),
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                  maxLines: 4,
                                ),
                              ),
                              //  Expanded(child: SizedBox(width: width / 3)),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            const Color(0XFF212121),
                                        content: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(70),
                                          ),
                                          width: width,
                                          height: height / 10,
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                videoUrl.removeAt(index);
                                                videoIds.removeAt(index);
                                                titles.removeAt(index);
                                                artist.removeAt(index);
                                                thumbNail.removeAt(index);
                                              });
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0XFF212121),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              maximumSize:
                                                  Size(width, height / 10),
                                            ),
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  '현재 스테이션 재생 목록에서 삭제',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.only(bottom: 10),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.more_vert),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

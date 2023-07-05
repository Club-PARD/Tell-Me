import 'package:dlive/screens/playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_parser/youtube_parser.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class StationMain extends StatefulWidget {
  const StationMain({super.key});

  @override
  State<StationMain> createState() => _StationMainState();
}

class _StationMainState extends State<StationMain> {
  late YoutubeMetaData metaYoutube;

  List<String> videoUrl = [
    'https://www.youtube.com/watch?v=fHI8X4OXluQ',
    'https://www.youtube.com/watch?v=ApXoWvfEYVU',
    'https://www.youtube.com/watch?v=mEZqJ65ra08',
    'https://www.youtube.com/watch?v=mNEUkkoUoIA',
    'https://www.youtube.com/watch?v=XR7Ev14vUh8',
    'https://www.youtube.com/watch?v=bfXsQ9k9PtY',

  ];
  List<String> videoIds = [];
  late List<String> titles = [];
  late List<String> artist = [];
  List<String> thumbNail = [];
  late List<YoutubePlayerController> cons;

   @override
  void initState() {
    super.initState();
    metaYoutube = const YoutubeMetaData();
    parseVideoUrls();
  }

  @override
  void dispose() {
    for (var controller in cons) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> parseVideoUrls() async{
    cons = [];
    for(String url in videoUrl){
      final String? videoId = getIdFromUrl(url);
      videoIds.add(videoId!);
      thumbNail.add('https://img.youtube.com/vi/$videoId/0.jpg');
      final controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false),
      );
      cons.add(controller);
      final videoMetaData = controller.metadata;
      titles.add(videoMetaData.title);
      artist.add(videoMetaData.author);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
   double width = screenSize.width;
    double height = screenSize.height;
    DateTime now = DateTime.now();
    String formatDate=DateFormat('yyyy-MM-dd').format(now);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios, color: Colors.black,)),
        title: const Text('방이름',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, '/navigation');}, icon: const Icon(Icons.home, color: Colors.black,))
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 15,),
              Container(
                width: width/3,
                height: height/4,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),child: Image.asset('assets/room_defualt_black.png'),
                ),
                const SizedBox(width: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('참여자',style: TextStyle(color: Color(0XFF929292)),),
                    const Text('멜로디언',style: TextStyle(),),
                    SizedBox(height: height/15,),
                    Text(formatDate),
                  ],
                ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 15,),
              ElevatedButton(onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlaylistScreen(
                                        videoUrl: videoIds,
                                        initialIndex: 0,
                                      ),
                                    ),
                                  );
              }, style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                    backgroundColor: MaterialStateProperty.all(Colors.black), minimumSize: MaterialStateProperty.all(Size(width*2/5, height/18))), child: const Row(
                      children: [
                        Icon(Icons.play_arrow, color: Colors.white),
                        SizedBox(width: 8),
                        Text('모두재생',style: TextStyle(color: Colors.white,)),
                      ],
                    )),
            const SizedBox(width: 20,),
            ElevatedButton(onPressed: (){
                           Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlaylistScreen(
                                        videoUrl: videoIds,
                                        initialIndex: 0,
                                      ),
                                    ),
                                  );
            }, style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                    backgroundColor: MaterialStateProperty.all(const Color(0XFFC0C0C0)), minimumSize: MaterialStateProperty.all(Size(width*2/5, height/18))), child: const Row(
                      children: [
                        Icon(Icons.shuffle),
                        SizedBox(width: 8,),
                        Text('다시재생',style: TextStyle(color: Colors.white,)),
                      ],
                    )),

            ],
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: FutureBuilder<void>(
              future: parseVideoUrls(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot){
                 if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Image.asset('assets/car_moving_final.gif'),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error occurred while parsing video URLs.'),
                  );
                }
                else{
                  return ListView.builder(
                    itemCount: videoUrl.length,
                    itemBuilder: (BuildContext context, index){
                      return GestureDetector(
                        onTap: () async{
                          Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlaylistScreen(
                                        videoUrl: videoIds,
                                        initialIndex: index,
                                      ),
                                    ),
                                  );
                        },
                        child: SizedBox(
                          width: width,
                          height: height/8,
                          child: 
                          Row(
                            children: [
                              const SizedBox(width: 5,),
                              const Icon(Icons.menu),
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                                width: width/3,
                                height: height/9,
                                child: Image.network(thumbNail[index],fit: BoxFit.fill, )),
                                const SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(titles[index]),
                                    const SizedBox(height: 10),
                                    Text(artist[index]),
                                  ],                               
                                ),
                                Expanded(child: SizedBox(width: width/3,)),
                                IconButton(onPressed: () {
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        backgroundColor: Colors.black,
                                       // contentPadding: EdgeInsets.zero,
                                        content: 
                                          Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(70)),
                                            width: width,
                                            height: height/8,
                                            child: TextButton(
                                              onPressed: (){
                                                
                                            },
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(30),
                                                                ),
                                                              ),
                                            ), 
                                            child: const Row(
                                              children: [
                                                Icon(Icons.delete, color: Colors.white,),
                                                //SizedBox(width: 10,),
                                                Text('현재 스테이션 재생 목록에서 삭제',style: TextStyle(color: Colors.white, fontSize: 16),),
                                              ],
                                            )),
                                          )
                                        
                                      );
                                    });
                                  }, icon: const Icon(Icons.more_vert))
                                
                            ],
                          ),
                        ),
                      );
                    } 
                    );
                }
              }
              )
          )
        ],
      ),
    );
  }
}
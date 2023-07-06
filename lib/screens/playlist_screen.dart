import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlaylistScreen extends StatefulWidget {
  List<String> videoUrl;
  int initialIndex;
  int count;
  List<String> title;

  PlaylistScreen({Key? key, required this.videoUrl, required this.initialIndex, required this.count, required this.title}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late YoutubePlayerController con;
  late int initialIndex;
  static late String youtubeId ;
  late int currentIndex;
  
  @override
  void initState() {
    super.initState();
 
    initialIndex=widget.initialIndex;
    currentIndex = initialIndex;
    youtubeId = widget.videoUrl[initialIndex];
    con = YoutubePlayerController(initialVideoId: youtubeId,
    flags: const YoutubePlayerFlags(
      showLiveFullscreenButton: false,
      autoPlay: true,
      mute: false,
    ),
    );
  }

  @override
  void dispose() {
    con.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_rounded)), forceMaterialTransparency: true,),
      body: Column(
        children: [
          YoutubePlayer(controller: con,
          onEnded: (data){
            setState(() {
            currentIndex = currentIndex + 1;
            con.load(widget.videoUrl[(currentIndex)%widget.videoUrl.length]);
            });
          },
          ),

          Expanded(
            child: ListView.builder(
                      itemCount: widget.videoUrl.length,
                      itemBuilder: (BuildContext context, index){
                        return GestureDetector(
                          onTap: () async{
                            setState(() {
                              currentIndex=index;
                           con.load(widget.videoUrl[index]);
                            });
                          },
                          child: SizedBox(
                            width: width,
                            height: height/8,
                            child: 
                            Row(
                              children: [
                                const SizedBox(width: 5,),
                                IconButton(onPressed: (){
                                  showDialog(context: context, builder: (BuildContext context){
                                        return AlertDialog(
                                          backgroundColor: Colors.black,
                                          content: 
                                            Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(70)),
                                              width: width,
                                              height: height/8,
                                              child: TextButton(onPressed: (){
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
                                                  Text('현재 스테이션 재생 목록에서 삭제',style: TextStyle(color: Colors.white, fontSize: 16),),
                                                ],
                                              )),
                                            )
                                          
                                        );
                                      });
                                }, icon: const Icon(Icons.menu, color: Color(0XFF929292),)),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                    currentIndex=index;
                                    con.load(widget.videoUrl[index]);
                            });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                                    width: width/3,
                                    height: height/9,
                                    child: Image.network('https://img.youtube.com/vi/${widget.videoUrl[index]}/0.jpg',fit: BoxFit.fill, )),
                                ),
                                  const SizedBox(width: 10,),
                                 // Expanded(child: SizedBox(width: width/3,)),
                                 
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
                                              child: Column(
                                                children: [
                                                  TextButton(onPressed: (){
                                                   con.load(widget.videoUrl[index+1]);
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
                                                      Icon(Icons.next_plan_outlined, color: Colors.white,),
                                                      Text('현재 재생목록에서 다음 순서로 재생',style: TextStyle(color: Colors.white, fontSize: 14),),
                                                    ],
                                                  )),
                                                  TextButton(onPressed: (){
                                                    con.load(widget.videoUrl[widget.videoUrl.length-1]);
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
                                                      Icon(Icons.last_page, color: Colors.white,),
                                                      //SizedBox(width: 10,),
                                                      Text('현재 재생목록의 마지막으로 재생',style: TextStyle(color: Colors.white, fontSize: 14),),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            )
                                          
                                        );
                                      });
                                    }, icon: const Icon(Icons.more_vert,color: Color(0XFFFFFFFF),))
                                  
                              ],
                            ),
                          ),
                        );
                      } 
                ),
          )
        ],
      ),
    );
  }
}
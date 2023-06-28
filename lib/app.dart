import 'package:dlive/screens/playing_youtube_screen.dart';
import 'package:dlive/screens/playlist_screen.dart';
import 'package:dlive/screens/room_detail_screen.dart';
import 'package:dlive/screens/room_list_screen.dart';
import 'package:flutter/material.dart';

class DLive extends StatelessWidget {
  const DLive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DLive',
      debugShowCheckedModeBanner: false,
      initialRoute: '/roomlist',
      routes: {
        '/roomlist': (context) => const RoomListScreen(),
        '/roomdetail': (context) => const RoomDetailScreen(),
        '/playlist': (context) => const PlaylistScreen(),
        '/playingyoutube': (context) => const PlayingYoutubeScreen(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Color(0xff888888),
      ),
    );
  }
}

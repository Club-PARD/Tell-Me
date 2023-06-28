import 'package:dlive/screens/core_music_add.dart';
import 'package:dlive/screens/room_list_screen.dart';
import 'package:dlive/screens/make_room.dart';
import 'package:flutter/material.dart';

class DLive extends StatelessWidget {
  const DLive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DLive',
      debugShowCheckedModeBanner: false,
      initialRoute: '/makeroom',
      routes: {
        '/': (context) => const RoomListScreen(),
        '/makeroom': (context) => const MakeRoom(),
        '/coremusicadd': (context) => const CoreMusicAdd(),
      },
    );
  }
}

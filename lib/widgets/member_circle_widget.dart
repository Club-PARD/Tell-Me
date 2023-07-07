import 'package:dlive/utils/room_util.dart';
import 'package:flutter/material.dart';

Widget getMemberCircles(BuildContext context, RoomProvider roomProvider) {
  return Stack(
    children: [
      Image.asset(
        'assets/circle1.png',
        width: MediaQuery.of(context).size.height / 812 * 17,
      ),
      for (int i = 2; i <= roomProvider.member.length; i++)
        Positioned(
          left: (i-1) * MediaQuery.of(context).size.height / 812 * 10,
          child: Image.asset(
            'asstes/circle$i',
            width: MediaQuery.of(context).size.height / 812 * 17,
          ),
        )
    ],
  );
}
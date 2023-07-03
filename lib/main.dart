import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';

import 'package:dlive/utils/host_util.dart';
import 'package:dlive/utils/room_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<HostProvider>(
        create: (_) => HostProvider(),
      ),
      ChangeNotifierProvider<RoomProvider>(
        create: (_) => RoomProvider(),
      ),
    ],
    child: DLive(),
  ));

  if (Platform.isMacOS) {
    final windowManager = WindowManager.instance;
    windowManager.setMinimumSize(const Size(1650, 1600));
    windowManager.setMaximumSize(const Size(1650, 1600));
  }
}

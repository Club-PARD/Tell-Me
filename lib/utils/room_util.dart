import 'package:flutter/material.dart';
import 'package:dlive/models/room_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomProvider extends ChangeNotifier {
  String _name = '';
  String _id = '';
  String _img =
      'https://firebasestorage.googleapis.com/v0/b/pard-dlive-b27d9.appspot.com/o/room_img%2Froom_default_color.png?alt=media&token=22258b36-f315-4bc5-b159-f7e73f98baba';
  String _url = '';
  String _playlist = '';
  List _member = [];

  String get name => _name;
  String get id => _id;
  String get img => _img;
  String get url => _url;
  String get playlist => _playlist;
  List get member => _member;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setId(String id) {
    _id = id;
    notifyListeners();
  }

  void setImg(String img) {
    _img = img;
    notifyListeners();
  }

  void setUrl(String url) {
    _url = url;
    notifyListeners();
  }

  void setPlaylist(String playlist) {
    _playlist = playlist;
    notifyListeners();
  }

  void setMember(List member) {
    _member = member;
    notifyListeners();
  }
}

class RoomUtil {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addRoom(String name, String id, String img, String url,
      String playlist, List member) async {
    User? user = auth.currentUser;
    CollectionReference hostCollection = firestore.collection('Host');
    DocumentReference hostDocument = hostCollection.doc(user!.uid);

    CollectionReference roomCollection = firestore.collection('Room');
    DocumentReference newRoomDocument = await roomCollection.add({
      'name': name,
      'id': id,
      'img': img,
      'url': url,
      'playlist': playlist,
      'member': member,
    });

    hostDocument.update({
      'room': FieldValue.arrayUnion([newRoomDocument.id]),
    });
  }

  Future<List<Room>> getRooms(List<dynamic> roomIds) async {
    List<Room> rooms = [];

    for (String roomId in roomIds) {
      DocumentSnapshot roomSnapshot =
          await firestore.collection('Room').doc(roomId).get();
      if (roomSnapshot.exists) {
        Map<String, dynamic> roomData =
            roomSnapshot.data() as Map<String, dynamic>;
        String name = roomData['name'];
        String id = roomData['id'];
        String img = roomData['img'];
        String url = roomData['url'];
        String playlist = roomData['playlist'];
        List<dynamic> member = roomData['member'];

        Room room = Room(
          name: name,
          id: id,
          img: img,
          url: url,
          playlist: playlist,
          member: member,
        );

        rooms.add(room);
      }
    }
    return rooms;
  }
}

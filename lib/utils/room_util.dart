import 'package:flutter/material.dart';
import 'package:dlive/models/room_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class RoomProvider extends ChangeNotifier {
  String _name = '';
  String _id = '';
  String _img =
      'https://firebasestorage.googleapis.com/v0/b/pard-dlive-b27d9.appspot.com/o/room_img%2Froom_default_color.png?alt=media&token=22258b36-f315-4bc5-b159-f7e73f98baba';
  String _url = '';
  List<List<String>> _playlist = [];
  List _member = [];
  List _rooms = [];
  List _selectedVideos = [];

  String get name => _name;
  String get id => _id;
  String get img => _img;
  String get url => _url;
  List<List<String>> get playlist => _playlist;
  List get member => _member;
  List get rooms => _rooms;
  List get selectedVideos => _selectedVideos;

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

  void setPlaylist(List<List<String>> playlist) {
    _playlist = playlist;
    notifyListeners();
  }

  void setMember(List member) {
    _member = member;
    notifyListeners();
  }

  void setRooms(List rooms) {
    _rooms = rooms;
    notifyListeners();
  }

  void setSelectedVideos(List selectedVideos) {
    _selectedVideos = selectedVideos;
    notifyListeners();
  }
}

class RoomUtil {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addRoom(String name, String id, String img, String url,
      /*String playlist,*/ List member) async {
    User? user = auth.currentUser;
    CollectionReference hostCollection = firestore.collection('Host');
    DocumentReference hostDocument = hostCollection.doc(user!.uid);

    CollectionReference roomCollection = firestore.collection('Room');
    DocumentReference newRoomDocument = await roomCollection.add({
      'name': name,
      'id': id,
      'img': img,
      'url': url,
      // 'playlist': playlist,
      'member': member,
      'timestamp': Timestamp.now()
    });

    hostDocument.update({
      'room': FieldValue.arrayUnion([newRoomDocument.id]),
    });
  }

  Future<void> getRooms(List roomIds, RoomProvider roomProvider) async {
    List<Room> rooms = [];

    for (var roomId in roomIds) {
      DocumentSnapshot roomSnapshot =
          await firestore.collection('Room').doc(roomId).get();
      if (roomSnapshot.exists) {
        Map<String, dynamic> roomData =
            roomSnapshot.data() as Map<String, dynamic>;
        String name = roomData['name'];
        String id = roomData['id'];
        String img = roomData['img'];
        String url = roomData['url'];
        // String playlist = roomData['playlist'];
        List member = roomData['member'];

        Room room = Room(
          name: name,
          id: id,
          img: img,
          url: url,
          // playlist: playlist,
          member: member,
        );

        rooms.add(room);
      }
    }
    roomProvider.setRooms(rooms);
  }

  Future<String> getRoomId(String roomId) async {
    // Query the document
    QuerySnapshot roomQuery =
        await firestore.collection('Room').where('id', isEqualTo: roomId).get();

    // Check if there are any documents returned
    if (roomQuery.docs.isNotEmpty) {
      // Get the document ID
      String docId = roomQuery.docs.first.id;
      return docId;
    } else {
      throw Exception("No room found with ID: $roomId");
    }
  }
}

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
  String _playlist = '';
  List _member = [];
  List _rooms = [];
  List _selectedVideos = [];
  List _videoTitles = [];

  String get name => _name;
  String get id => _id;
  String get img => _img;
  String get url => _url;
  String get playlist => _playlist;
  List get member => _member;
  List get rooms => _rooms;
  List get selectedVideos => _selectedVideos;
  List get videoTitles => _videoTitles;

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

  void setRooms(List rooms) {
    _rooms = rooms;
    notifyListeners();
  }

  void setSelectedVideos(List selectedVideos) {
    _selectedVideos = selectedVideos;
    notifyListeners();
  }

  void setVideoTitles(List videoTitles) {
    _videoTitles = videoTitles;
    notifyListeners();
  }
}

class RoomUtil {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addRoom(String name, String id, String img, String url,
      String playlist, List member, List videoTitles) async {
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
      'videoTitles': videoTitles,
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
        String name = roomData['name'] ?? ''; // If null, assign empty string
        String id = roomData['id'] ?? ''; // If null, assign empty string
        String img = roomData['img'] ?? ''; // If null, assign empty string
        String url = roomData['url'] ?? ''; // If null, assign empty string
        String playlist =
            roomData['playlist'] ?? ''; // If null, assign empty string
        List member = roomData['member'] ?? []; // If null, assign empty list
        List videoTitles =
            roomData['videoTitles'] ?? []; // If null, assign empty list

        Room room = Room(
          name: name,
          id: id,
          img: img,
          url: url,
          playlist: playlist,
          member: member,
          videoTitles: videoTitles,
        );

        rooms.add(room);
      }
    }
    roomProvider.setRooms(rooms);
  }

  // Future<void> getRooms(List roomIds, RoomProvider roomProvider) async {
  //   List<Room> rooms = [];

  //   for (var roomId in roomIds) {
  //     DocumentSnapshot roomSnapshot =
  //         await firestore.collection('Room').doc(roomId).get();
  //     if (roomSnapshot.exists) {
  //       Map<String, dynamic> roomData =
  //           roomSnapshot.data() as Map<String, dynamic>;
  //       String name = roomData['name'];
  //       String id = roomData['id'];
  //       String img = roomData['img'];
  //       String url = roomData['url'];
  //       String playlist = roomData['playlist'];
  //       List member = roomData['member'];
  //       List videoTitles = roomData['videoTitles'];

  //       Room room = Room(
  //         name: name,
  //         id: id,
  //         img: img,
  //         url: url,
  //         playlist: playlist,
  //         member: member,
  //         videoTitles: videoTitles,
  //       );

  //       rooms.add(room);
  //     }
  //   }
  //   roomProvider.setRooms(rooms);
  // }

  Future<void> updatePlaylistInRoom(String roomId, String playlistId) async {
    CollectionReference roomCollection = firestore.collection('Room');

    // Use roomId to find the document
    var roomQuery = await roomCollection.where('id', isEqualTo: roomId).get();

    // Check if a document was found
    if (roomQuery.docs.isNotEmpty) {
      DocumentReference roomDocument =
          roomCollection.doc(roomQuery.docs.first.id);

      return roomDocument.update({
        'playlist': playlistId,
      });
    } else {
      // Handle error, for example throw an exception
      throw Exception('Room not found');
    }
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

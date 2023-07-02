import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HostProvider extends ChangeNotifier {

  String _name = '';
  String _email = '';
  String _character = 'assets/character_pale.png';
  List _room = [];

  String get name => _name;
  String get email => _email;
  String get character => _character;
  List get room => _room;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setCharacter(String character) {
    _character = character;
    notifyListeners();
  }

  void setRoom(List room) {
    _room = room;
    notifyListeners();
  }
}

class HostUtil {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> addHost(String name, String email, String character) async {
    User? user = auth.currentUser;

    try {
      await firestore.collection('Host').doc(user!.uid).set({
      'name': name,
      'email': email,
      'character': character,
      'room': [],
    });
    } catch (e) {
      print('Error adding host: $e');
    }
  }

  Future<void> getHost(HostProvider hostProvider) async {
    
    User? user = auth.currentUser;
    String uid = user!.uid;
    DocumentSnapshot snapshot = await firestore.collection('Host').doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      String name = data['name'];
      String email = data['email'];
      String character = data['character'];
      List room = data['room'];

      hostProvider.setName(name);
      hostProvider.setEmail(email);
      hostProvider.setCharacter(character);
      hostProvider.setRoom(room);
    }
  }
}
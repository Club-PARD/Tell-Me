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

class ProfileProvider extends ChangeNotifier {
  String _name = '';
  String _character = '';

  String get name => _name;
  String get character => _character;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setCharacter(String character) {
    _character = character;
    notifyListeners();
  }
}

// class QrProvider extends ChangeNotifier {
//   String _name = '';
//   String _character = '';

//   String get name => _name;
//   String get character => _character;

//   void setName(String name) {
//     _name = name;
//     notifyListeners();
//   }

//   void setCharacter(String character) {
//     _character = character;
//     notifyListeners();
//   }
// }

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

  Future<void> updateHostCharacterAndName(String character, String name) async {
    User? user = auth.currentUser;

    try {
      await firestore.collection('Host').doc(user!.uid).update({
        'character': character,
        'name': name,
      });
    } catch (e) {
      print('Error updating host character andd name: $e');
    }
  }

  Future<void> getHost(HostProvider hostProvider) async {
    User? user = auth.currentUser;
    String uid = user!.uid;
    DocumentSnapshot snapshot =
        await firestore.collection('Host').doc(uid).get();
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

  String getCar(String character) {
    String paleCar = 'assets/pale-car.gif';
    String pinkCar = 'assets/pink-car.gif';
    String yellowCar = 'assets/yellow-car.gif';
    String greenCar = 'assets/green-car.gif';
    String blueCar = 'assets/blue-car.gif';
    switch (character) {
      case 'assets/character_pale.png':
        return paleCar;
      case 'assets/character_pink.png':
        return pinkCar;
      case 'assets/character_yellow.png':
        return yellowCar;
      case 'assets/character_green.png':
        return greenCar;
      case 'assets/character_blue.png':
        return blueCar;
    }
    return pinkCar;
  }

  String getProfile(String character) {
    String paleProfile = 'assets/pale_profile.png';
    String pinkProfile = 'assets/pink_profile.png';
    String yellowProfile = 'assets/yellow_profile.png';
    String greenProfile = 'assets/green_profile.png';
    String blueProfile = 'assets/blue_profile.png';
    switch (character) {
      case 'assets/character_pale.png':
        return paleProfile;
      case 'assets/character_pink.png':
        return pinkProfile;
      case 'assets/character_yellow.png':
        return yellowProfile;
      case 'assets/character_green.png':
        return greenProfile;
      case 'assets/character_blue.png':
        return blueProfile;
    }
    return pinkProfile;
  }

  String getQr(String character) {
    String purpleQr = 'assets/purple_qr.png';
    String pinkQr = 'assets/pink_qr.png';
    String yellowQr = 'assets/yellow_qr.png';
    String greenQr = 'assets/green_qr.png';
    String blueQr = 'assets/blue_qr.png';
    switch (character) {
      case 'assets/character_pale.png':
        return purpleQr;
      case 'assets/character_pink.png':
        return pinkQr;
      case 'assets/character_yellow.png':
        return yellowQr;
      case 'assets/character_green.png':
        return greenQr;
      case 'assets/character_blue.png':
        return blueQr;
    }
    return pinkQr;
  }
}

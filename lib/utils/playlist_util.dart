import 'package:cloud_firestore/cloud_firestore.dart';

class PlaylistUtil {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> addPlaylist(List<List<String>> songs) async {
    CollectionReference playlistCollection = firestore.collection('Playlist');

    // Convert the nested List into a Map
    Map<String, List<String>> songsMap = {};
    for (int i = 0; i < songs.length; i++) {
      songsMap['song$i'] = songs[i];
    }

    // Create a new document and get a reference to it
    DocumentReference newPlaylistDoc = await playlistCollection.add({
      'songs': songsMap,
      'timestamp': Timestamp.now(),
    });

    // Update the new document to include its own ID in a field
    await newPlaylistDoc.update({
      'id': newPlaylistDoc.id,
    });

    // Return the document's ID
    return newPlaylistDoc.id;
  }

  // Future<List<List<String>>> getSongs(String playlistId) async {
  //   DocumentSnapshot playlistSnapshot =
  //       await firestore.collection('Playlist').doc(playlistId).get();

  //   if (playlistSnapshot.exists) {
  //     Map<String, dynamic> playlistData =
  //         playlistSnapshot.data() as Map<String, dynamic>;

  //     // Convert the map back to a nested list
  //     List<List<String>> songs = [];
  //     Map<String, List<String>> songsMap =
  //         Map<String, List<String>>.from(playlistData['songs']);
  //     songsMap.forEach((_, song) {
  //       songs.add(song);
  //     });

  //     return songs;
  //   } else {
  //     throw Exception('Playlist not found');
  //   }
  // }

  Future<List<List<String>>> getSongs(String playlistId) async {
    DocumentSnapshot playlistSnapshot =
        await firestore.collection('Playlist').doc(playlistId).get();

    if (playlistSnapshot.exists) {
      Map<String, dynamic> playlistData =
          playlistSnapshot.data() as Map<String, dynamic>;

      // Convert the map back to a nested list
      List<List<String>> songs = [];
      Map<String, dynamic> songsMap = playlistData['songs'];

      songsMap.forEach((_, song) {
        songs.add(List<String>.from(song));
      });

      return songs;
    } else {
      throw Exception('Playlist not found');
    }
  }

  Future<String?> getPlaylistIdFromRoom(String roomId) async {
    CollectionReference roomCollection = firestore.collection('Room');

    // Use roomId to find the document
    var roomQuery = await roomCollection.where('id', isEqualTo: roomId).get();

    // Check if a document was found
    if (roomQuery.docs.isNotEmpty) {
      // Return the 'playlist' field of the document
      return roomQuery.docs.first.get('playlist');
    } else {
      // Handle error, for example return null
      return null;
    }
  }
}

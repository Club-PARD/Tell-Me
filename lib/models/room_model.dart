class Room {
  late String name;
  late String id;
  late String img;
  late String url;
  late String playlist;
  late List member;
  late List videoTitles;

  Room({
    required this.name,
    required this.img,
    required this.url,
    required this.playlist,
    required this.member,
    required this.videoTitles,
    required String id,
  });
}

class YoutubeMeta{
  final String title;
  final String id;

  YoutubeMeta({
    required this.title,
    required this.id,
  });

  factory YoutubeMeta.fromMap(Map<String,dynamic> snippet, String id){
    return YoutubeMeta(
      title: snippet['title'],
      id:id
    );
  }
}
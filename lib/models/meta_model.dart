class YoutubeTitle{
  final String title;

  YoutubeTitle({
    required this.title,
  });

  factory YoutubeTitle.fromMap(Map<String,dynamic> snippet){
    return YoutubeTitle(
      title: snippet['title'],
    );
  }
}
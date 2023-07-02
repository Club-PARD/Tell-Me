class YoutubeVideo {
  final String id;
  final String title;
  final String thumbnailUrl;

  YoutubeVideo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory YoutubeVideo.fromMap(Map<String, dynamic> snippet, String id) {
    return YoutubeVideo(
      id: id,
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
    );
  }

  // 비디오 타이틀에서 단어를 분리하여 리스트로 반환
  List<String> getKeywords() {
    return title.split(' ');
  }
}

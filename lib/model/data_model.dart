// import 'package:json_annotation/json_annotation.dart';

// part 'data_model.g.dart';

// class DataModel {}

// @JsonSerializable()
// class VideoItems {
//   String id;
//   VideoSnippet snippet;
//   VideoStatistics statistics;

//   VideoItems(
//       {required this.id, required this.snippet, required this.statistics});

//   factory VideoItems.fromJson(Map<String, dynamic> json) =>
//       _$VideoItemsFromJson(json);

//   Map<String, dynamic> toJson() => _$VideoItemsToJson(this);
// }

// @JsonSerializable()
// class VideoSnippet {
//   String publishedAt;
//   String title;
//   VideoThumbnail thumbnails;

//   VideoSnippet(
//       {required this.publishedAt,
//       required this.title,
//       required this.thumbnails});

//   factory VideoSnippet.fromJson(Map<String, dynamic> json) =>
//       _$VideoSnippetFromJson(json);

//   Map<String, dynamic> toJson() => _$VideoSnippetToJson(this);
// }

// @JsonSerializable()
// class VideoThumbnail {
//   // ThumbnailURL defaultURL;
//   ThumbnailURL medium;
//   ThumbnailURL high;

//   VideoThumbnail({required this.medium, required this.high});

//   factory VideoThumbnail.fromJson(Map<String, dynamic> json) =>
//       _$VideoThumbnailFromJson(json);

//   Map<String, dynamic> toJson() => _$VideoThumbnailToJson(this);
// }

// @JsonSerializable()
// class ThumbnailURL {
//   String url;

//   ThumbnailURL({required this.url});

//   factory ThumbnailURL.fromJson(Map<String, dynamic> json) =>
//       _$ThumbnailURLFromJson(json);

//   Map<String, dynamic> toJson() => _$ThumbnailURLToJson(this);
// }

// @JsonSerializable()
// class VideoStatistics {
//   String viewCount;

//   VideoStatistics({required this.viewCount});

//   factory VideoStatistics.fromJson(Map<String, dynamic> json) =>
//       _$VideoStatisticsFromJson(json);

//   Map<String, dynamic> toJson() => _$VideoStatisticsToJson(this);
// }

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:youtube/model/data_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://www.googleapis.com/youtube/v3/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/videos")
  Future<Map<String, List<VideoItems>>> getYoutubeAPI(
      @Query("id") String videoId,
      @Query("key") String devKey,
      @Query("fields") String fields,
      @Query("part") String part);
}

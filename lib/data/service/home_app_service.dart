import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/get_task_response.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;

import '../model/news_list_response.dart';

part 'home_app_service.g.dart';

@RestApi()
abstract class HomeAppService {
  factory HomeAppService(Dio dio, {String baseUrl}) = _HomeAppService;

  @GET(basePath.api_get_task_user)
  Future<GetTaskResponse> getTaskUser(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
  );

  @GET(basePath.api_get_news_list)
  Future<NewsListResponse> getNewsList(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
  );

  @GET(basePath.api_count_task)
  Future<NewsListResponse> getCount(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
  );
}

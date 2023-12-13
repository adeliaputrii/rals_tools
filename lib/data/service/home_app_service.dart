import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/get_task_response.dart';
import '../model/get_news_response.dart';

part 'home_app_service.g.dart';

@RestApi()
abstract class HomeAppService {
  factory HomeAppService(Dio dio, {String baseUrl}) = _HomeAppService;

  @GET('v1/activity/task/get-task')
  Future<GetTaskResponse> getTaskUser();

  @GET('v1/news/get')
  Future<GetNewsResponse> getListNews();
}

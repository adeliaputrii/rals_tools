import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:retrofit/retrofit.dart';
import '../model/create_my_log_body.dart';
import '../model/data_customer_response.dart';
import '../model/myactivity_task_response.dart';
import '../model/myactvitity_project_response.dart';
import '../model/login_body.dart';
import '../model/login_response.dart';

part 'myactivity_service.g.dart';

@RestApi()
abstract class MyActivityService {
  factory MyActivityService(Dio dio, {String baseUrl}) = _MyActivityService;

  @GET('v1/activity/list-project')
  Future<GetProjectResponse> getProject();

  @GET('v1/activity/list-task?project_id={project_id}')
  Future<MyActivityTaskResponse> getTaskById(
      @Path("project_id") String projectId);
}

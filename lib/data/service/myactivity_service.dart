import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:myactivity_project/data/model/get_task_response.dart';
import 'package:myactivity_project/data/model/myactivity_body.dart';
import 'package:myactivity_project/data/model/myactivity_edit_body.dart';
import 'package:myactivity_project/data/model/myactivity_edit_response.dart';
import 'package:myactivity_project/data/model/myactivity_response.dart';
import 'package:myactivity_project/data/model/myactivity_update_body.dart';
import 'package:myactivity_project/data/model/myactivity_update_response.dart';
import 'package:retrofit/retrofit.dart';
import '../model/create_my_log_body.dart';
import '../model/data_customer_response.dart';
import '../model/myactivity_task_response.dart';
import '../model/myactvitity_project_response.dart';
import '../model/login_body.dart';
import '../model/login_response.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;

part 'myactivity_service.g.dart';

@RestApi()
abstract class MyActivityService {
  factory MyActivityService(Dio dio, {String baseUrl}) = _MyActivityService;

  @GET(basePath.api_activity_list_project)
  Future<GetProjectResponse> getProject(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
  );

  @GET(basePath.api_get_task_user)
  Future<GetTaskResponse> getTaskUser(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
  );

  @GET('${basePath.api_activity_task_by_id}{project_id}')
  Future<MyActivityTaskResponse> getTaskById(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Path("project_id") String projectId
  );

  @POST(basePath.api_activity_create_daily)
  Future<MyActivityResponse> submitActivity(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() MyActivityBody myActivityBody
  );

  @POST(basePath.api_activity_clock_daily)
  Future<MyActivityEditResponse> editActivity(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() MyActivityEditBody myActivityEditBody
  );

  @POST(basePath.api_activity_update)
  Future<MyActivityUpdateResponse> updateActivity(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() MyActivityUpdateBody myActivityUpdateBody
  );
}

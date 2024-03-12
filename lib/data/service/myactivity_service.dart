import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
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

part 'myactivity_service.g.dart';

@RestApi()
abstract class MyActivityService {
  factory MyActivityService(Dio dio, {String baseUrl}) = _MyActivityService;

  @GET('v1/activity/list-project')
  Future<GetProjectResponse> getProject();

  @GET('v1/activity/list-task?project_id={project_id}')
  Future<MyActivityTaskResponse> getTaskById(
      @Path("project_id") String projectId);

  @POST('v1/activity/create_daily_activity')
  Future<MyActivityResponse> submitActivity(
      @Body() MyActivityBody myActivityBody);
  
  @POST('v1/activity/clock_daily_activity')
  Future<MyActivityEditResponse> editActivity(
      @Body() MyActivityEditBody myActivityEditBody);

   @POST('v1/activity/updateDailyActivity')
  Future<MyActivityUpdateResponse> updateActivity(
      @Body() MyActivityUpdateBody myActivityUpdateBody);
}

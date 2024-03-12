import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:retrofit/retrofit.dart';
import '../model/create_my_log_body.dart';
import '../model/data_customer_response.dart';
import '../model/login_body.dart';
import '../model/login_response.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;

import '../model/logout_response.dart';
part 'login_service.g.dart';

@RestApi()
abstract class LoginService {
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;

  @POST(basePath.api_login)
  Future<LoginResponse> login(@Body() LoginBody loginBody);

  @POST(basePath.api_membercard_customer)
  Future<DataCustomerResponse> getDataCustomer(@Field("id_user") String userId);

  @POST(basePath.api_my_log)
  Future<LoginResponse> createLog(@Body() CreateLogBody createLogBody);

  @POST(basePath.api_logout)
  Future<LogoutResponse> logout();
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:retrofit/retrofit.dart';
import '../model/create_my_log_body.dart';
import '../model/data_customer_response.dart';
import '../model/login_body.dart';
import '../model/login_response.dart';

part 'login_service.g.dart';

@RestApi()
abstract class LoginService {
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;

  @POST('api/v1/auth/signin')
  Future<LoginResponse> login(@Body() LoginBody loginBody);

  @POST('v1/membercards/tbl_customer')
  Future<DataCustomerResponse> getDataCustomer(@Field("id_user") String userId);

  @POST('v1/activity/createmylog')
  Future<LoginResponse> createLog(@Body() CreateLogBody createLogBody);
}

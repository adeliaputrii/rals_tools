import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:retrofit/retrofit.dart';
import '../model/create_my_log_body.dart';
import '../model/data_customer_response.dart';
import '../model/data_member_card_body.dart';
import '../model/data_member_card_response.dart';
import '../model/login_body.dart';
import '../model/login_response.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;
part 'id_cash_service.g.dart';

@RestApi()
abstract class IDCashService {
  factory IDCashService(Dio dio, {String baseUrl}) = _IDCashService;

  @POST(basePath.api_membercard_customer)
  Future<DataMemberCardResponse> getDataMember(@Body() DataMemberCardBody body);
}

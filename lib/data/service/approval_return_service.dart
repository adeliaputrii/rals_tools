import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:myactivity_project/data/model/approval_return_body.dart';
import 'package:myactivity_project/data/model/approval_return_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;

part 'approval_return_service.g.dart';

@RestApi()
abstract class ApprovalReturnService {
  factory ApprovalReturnService(Dio dio, {String baseUrl}) = _ApprovalReturnService;


  @POST(basePath.api_approval_my_transc)
  Future<ApprovalReturnResponse> getDataMember(@Body() ApprovalReturnBody body);
}

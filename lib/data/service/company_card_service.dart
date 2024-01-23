import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/company_card_response.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;

part 'company_card_service.g.dart';

@RestApi()
abstract class CompanyCardService {
  factory CompanyCardService(Dio dio, {String baseUrl}) = _CompanyCardService;

  @POST(basePath.api_get_company_card)
  Future<CompanyCardResponse> getDataMember(@Body() String noKartu);
}

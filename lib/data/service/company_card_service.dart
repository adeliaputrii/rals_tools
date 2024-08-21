import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/company_card_detail_response.dart';
import '../model/company_card_history_body.dart';
import '../model/company_card_history_days_response.dart';
import '../model/company_card_history_month_response.dart';
import '../model/company_card_history_response.dart';
import '../model/company_card_history_year_response.dart';
import '../model/company_card_response.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;

part 'company_card_service.g.dart';

@RestApi()
abstract class CompanyCardService {
  factory CompanyCardService(Dio dio, {String baseUrl}) = _CompanyCardService;

  @POST(basePath.api_get_company_card)
  Future<CompanyCardResponse> getDataMember(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() String noKartu
  );

  @POST(basePath.api_get_company_card_detail)
  Future<CompanyCardDetailResponse> getDetailCard(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() String noKartu
  );

  @POST(basePath.api_get_company_card_history)
  Future<CompanyCardHistoryResponse> getHistoryMember(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() CompanyCardHistoryBody body
  );

  @POST(basePath.api_get_company_card_history_year)
  Future<CompanyCardHistoryYearResponse> getHistoryMemberYear(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() CompanyCardHistoryBody body
  );

  @POST(basePath.api_get_company_card_history_month)
  Future<CompanyCardHistoryMonthResponse> getHistoryMemberMonth(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() CompanyCardHistoryBody body)
  ;

  @POST(basePath.api_get_company_card_history_day)
  Future<CompanyCardHistoryResponse> getHistoryMemberDay(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() CompanyCardHistoryBody body
  );
}

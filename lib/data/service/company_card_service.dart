import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
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
  Future<CompanyCardResponse> getDataMember(@Body() String noKartu);

  @POST(basePath.api_get_company_card_detail)
  Future<CompanyCardResponse> getDetailCard(@Body() String noKartu);

  @POST(basePath.api_get_company_card_history)
  Future<CompanyCardHistoryResponse> getHistoryMember(
      @Body() CompanyCardHistoryBody body);

  @POST(basePath.api_get_company_card_history_year)
  Future<CompanyCardHistoryYearResponse> getHistoryMemberYear(
      @Body() CompanyCardHistoryBody body);

  @POST(basePath.api_get_company_card_history_month)
  Future<CompanyCardHistoryMonthResponse> getHistoryMemberMonth(
      @Body() CompanyCardHistoryBody body);

  @POST(basePath.api_get_company_card_history_day)
  Future<CompanyCardHistoryDaysResponse> getHistoryMemberDay(
      @Body() CompanyCardHistoryBody body);
}

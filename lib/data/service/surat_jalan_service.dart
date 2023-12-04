import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:retrofit/retrofit.dart';

import '../model/surat_jalan_response.dart';

part 'surat_jalan_service.g.dart';

@RestApi()
abstract class SuratJalanService {
  factory SuratJalanService(Dio dio, {String baseUrl}) = _SuratJalanService;

  @GET('v1/tracking/scan-sj-tracking?no_sj={no}')
  Future<SuratJalanResponse> getScanTracking(@Path("no") String noSJ);
}

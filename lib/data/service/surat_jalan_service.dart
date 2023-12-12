import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:myactivity_project/data/model/scan_sj_response.dart';
import 'package:retrofit/retrofit.dart';

import '../model/surat_jalan_response.dart';
import '../model/scan_sj_body.dart';
import '../model/track_sj_response.dart';

part 'surat_jalan_service.g.dart';

@RestApi()
abstract class SuratJalanService {
  factory SuratJalanService(Dio dio, {String baseUrl}) = _SuratJalanService;

  @GET('v1/tracking/scan-sj-tracking?no_sj={no_sj}')
  Future<SuratJalanResponse> getScanTracking(@Path("no_sj") String noSJ);

  @POST('v1/tracking/update-tracking/storeline')
  Future<ScanSJResponse> postTrackingStoreline(@Body() TrackingSJBody body);

  @POST('v1/tracking/update-tracking/supplier')
  Future<ScanSJResponse> postTrackingSupplier(@Body() TrackingSJBody body);

  @POST('v1/tracking/update-tracking')
  Future<ScanSJResponse> postTrackingDefault(@Body() TrackingSJBody body);

  @GET('v1/tracking/track-sj?no_sj={no_sj}')
  Future<TrackingSJResponse> trackSJ(@Path("no_sj") String noSJ);
}

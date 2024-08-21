import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:myactivity_project/data/model/scan_sj_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;

import '../model/surat_jalan_response.dart';
import '../model/scan_sj_body.dart';
import '../model/track_sj_response.dart';

part 'surat_jalan_service.g.dart';

@RestApi()
abstract class SuratJalanService {
  factory SuratJalanService(Dio dio, {String baseUrl}) = _SuratJalanService;

  @GET('${basePath.api_tracking_scan}{no_sj}')
  Future<SuratJalanResponse> getScanTracking(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Path("no_sj") String noSJ
  );

  @POST(basePath.api_tracking_update_storeline)
  Future<ScanSJResponse> postTrackingStoreline(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() TrackingSJBody body
  );

  @POST(basePath.api_tracking_update_supplier)
  Future<ScanSJResponse> postTrackingSupplier(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() TrackingSJBody body
  );

  @POST(basePath.api_tracking_update_tracking)
  Future<ScanSJResponse> postTrackingDefault(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() TrackingSJBody body
  );

  @GET('${basePath.api_tracking_sj}{no_sj}')
  Future<TrackingSJResponse> trackSJ(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Path("no_sj") String noSJ
  );
}

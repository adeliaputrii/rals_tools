import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:myactivity_project/data/model/stock_opname_body.dart';
import 'package:myactivity_project/data/model/stock_opname_list_response.dart';
import 'package:myactivity_project/data/model/stock_opname_response.dart';
import 'package:myactivity_project/data/model/stock_opname_submit_body.dart';
import 'package:myactivity_project/data/model/stock_opname_submit_reponse.dart';
import 'package:retrofit/retrofit.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;

part 'stock_opname_service.g.dart';


@RestApi()
abstract class StockOpnameService {
  factory StockOpnameService(Dio dio, {String baseUrl}) = _StockOpnameService;

  @GET(basePath.api_get_pos_location)
  Future<StockOpnameResponse> getPosLocation(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() StockOpnameGetBody body
  );

  @POST(basePath.api_submit_so)
  Future<StockOpnameSubmitResponse> postResult(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() StockOpnameSubmitBody body
  );
}

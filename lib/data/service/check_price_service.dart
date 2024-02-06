// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:myactivity_project/base/base_params.dart';
// import 'package:myactivity_project/base/base_paths.dart' as basePath;
// import 'package:retrofit/http.dart';

// import '../model/check_price_response.dart';
// part 'check_price_service.g.dart';

// @RestApi()
// abstract class CheckPriceService {
//   factory CheckPriceService(Dio dio, {String baseUrl}) = _CheckPriceService;

//   @POST(basePath.api_login)
//   Future<CheckPriceResponse> login(@Body() LoginBody loginBody);

// }
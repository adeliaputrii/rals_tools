// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:get_it/get_it.dart';
// import 'package:myactivity_project/data/model/check_price_body.dart';
// import 'package:myactivity_project/data/service/check_price_service.dart';
// import '../../service/SP_service/SP_service.dart';
// import '../model/repositories_response.dart';
// import 'package:dio/dio.dart';

// class CheckPriceRepositories {
//   Future<RepositoriesResponse> checkprice(CheckPriceBody checkPriceBody) async {
//     final services = GetIt.I.get<CheckPriceService>();

//     late RepositoriesResponse response;

//     try {
//       await services.checkprice(checkPriceBody).then((value) {
//         response = RepositoriesResponse(
//             isSuccess: true, statusCode: value.status, dataResponse: value);
//       });
//     } catch (e) {
//       if (e is IOException) {
//         response = RepositoriesResponse(
//             isSuccess: false, statusCode: 500, dataResponse: e.toString());
//       } else {
//         response = RepositoriesResponse(
//             isSuccess: false, statusCode: 0, dataResponse: e.toString());
//       }
//       if (e is DioException) {
//         response = RepositoriesResponse(
//             isSuccess: false,
//             statusCode: e.response?.statusCode,
//             dataResponse: e.response?.data['message'].toString() ??
//                 'Please check your connection..');

//         debugPrint(e.response?.data['message'] ?? 'Failed');
//       }
//     }
//     return response;
//   }

// }

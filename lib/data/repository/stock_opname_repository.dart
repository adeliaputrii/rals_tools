import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/model/stock_opname_body.dart';
import 'package:myactivity_project/data/model/stock_opname_submit_body.dart';
import 'package:myactivity_project/data/service/stock_opname_service.dart';
import 'package:myactivity_project/data/service/surat_jalan_service.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import '../model/login_body.dart';
import '../model/repositories_response.dart';
import '../model/scan_sj_body.dart';

class StockOpnameRepositories {
  Future<RepositoriesResponse> getPosLocation(
    String token,
    StockOpnameGetBody body
    ) async {
    final services = GetIt.I.get<StockOpnameService>();

    late RepositoriesResponse response;

    try {
      await services.getPosLocation(
        basePath.contentType, basePath.accept, token, body
        ).then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: value.status, dataResponse: value);
      });
    } catch (e) {
      if (e is IOException) {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 0, dataResponse: 'Harap coba lagi..');
      }

      if (e is DioException) {
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response!.data['message'].toString());
      }
    }

    return response;
  }

    Future<RepositoriesResponse> postResult(
      String token,
      StockOpnameSubmitBody body) async {
    final services = GetIt.I.get<StockOpnameService>();

    late RepositoriesResponse response;

    try {
      await services.postResult(basePath.contentType, basePath.accept, token,  body).then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: value.status, dataResponse: value);
      });
    } catch (e) {
      if (e is IOException) {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 0, dataResponse: 'Harap coba lagi..');
      }

      if (e is DioException) {
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response!.data['message'].toString());
      }
    }

    return response;
  }
}

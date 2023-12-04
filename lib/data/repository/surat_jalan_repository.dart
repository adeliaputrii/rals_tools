import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/service/surat_jalan_service.dart';

import '../model/login_body.dart';
import '../model/repositories_response.dart';

class SuratJalanRepositories {
  Future<RepositoriesResponse?> getScanTracking(String noSJ) async {
    final services = GetIt.I.get<SuratJalanService>();

    late RepositoriesResponse response;

    try {
      await services.getScanTracking(noSJ).then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: value.status, dataResponse: value);
      });
    } catch (e) {
      if (e is DioException) {
        return response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response!.data['message'].toString());
      }
      if (e is IOException) {
        return response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        return response = RepositoriesResponse(
            isSuccess: false, statusCode: 0, dataResponse: e.toString());
      }
    }
  }
}

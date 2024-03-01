import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../model/repositories_response.dart';
import '../service/report_service.dart';

class ReportRepositories {
  Future<RepositoriesResponse> getListReport() async {
    final services = GetIt.I.get<ReportService>();

    late RepositoriesResponse response;

    try {
      await services.getListReport().then((value) {
        response = RepositoriesResponse(isSuccess: true, statusCode: 200, dataResponse: value);
      });
    } catch (e) {
      if (e is IOException) {
        response = RepositoriesResponse(isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        response = RepositoriesResponse(isSuccess: false, statusCode: 0, dataResponse: e.toString());
      }
      if (e is DioException) {
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response?.data['message'].toString() ?? 'Please check your connection..');
      }
    }
    return response;
  }
}

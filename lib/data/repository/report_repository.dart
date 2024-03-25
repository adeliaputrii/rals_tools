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

  Future<RepositoriesResponse> getListReportPagination(String? cursor, String? title, String? startDate, String? endDate, String? version) async {
    final services = GetIt.I.get<ReportService>();

    late RepositoriesResponse response;

    try {
      await services.searchListReport(cursor, title, startDate, endDate, version).then((value) {
        response = RepositoriesResponse(isSuccess: true, statusCode: 200, dataResponse: value);
      });
    } catch (e) {
      if (e is IOException) {
        response = RepositoriesResponse(isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        response = RepositoriesResponse(isSuccess: false, statusCode: 0, dataResponse: e.toString());
        print(' exception ${e}');
      }
      if (e is DioException) {
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response?.data['message'].toString() ?? 'Please check your connection..');
        print('dio exception ${e}');
      }
    }
    return response;
  }

  Future<RepositoriesResponse> searchListReport(String? cursor, String? title, String? startDate, String? endDate, String? version) async {
    final services = GetIt.I.get<ReportService>();

    late RepositoriesResponse response;

    try {
      await services.searchListReport(cursor, title, startDate, endDate, version).then((value) {
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

  Future<RepositoriesResponse> insertViewer(String idReport) async {
    final services = GetIt.I.get<ReportService>();

    late RepositoriesResponse response;

    try {
      await services.insertViewer(idReport).then((value) {
        response = RepositoriesResponse(isSuccess: true, statusCode: 200, dataResponse: "Sukses");
      });
    } catch (e) {
      if (e is IOException) {
        response = RepositoriesResponse(isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        response = RepositoriesResponse(isSuccess: false, statusCode: 0, dataResponse: e.toString());
      }
      if (e is DioException) {
        print('insert exception ${e}');
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response?.data['message'].toString() ?? 'Please check your connection..');
      }
    }
    return response;
  }
}

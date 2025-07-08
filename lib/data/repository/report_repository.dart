import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import 'package:myactivity_project/data/model/report_dynamic_body.dart';
import 'package:myactivity_project/data/model/report_get_store_body.dart';
import 'package:myactivity_project/data/model/report_sales_body.dart';
import 'package:myactivity_project/tools/settingsralstools.dart';

import '../model/repositories_response.dart';
import '../service/report_service.dart';

class ReportRepositories {
  Future<RepositoriesResponse> getListReport(String token) async {
    final services = GetIt.I.get<ReportService>();

    late RepositoriesResponse response;

    try {
      
      await services
          .getListReport(basePath.contentType, basePath.accept, token)
          .then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: 200, dataResponse: value);
      });
    } catch (e) {
      if (e is IOException) {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 0, dataResponse: e.toString());
      }
      if (e is DioException) {
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response?.data['message'].toString() ??
                'Please check your connection..');
      }
    }
    return response;
  }

  Future<RepositoriesResponse> getListReportPagination(
      String token,
      String? cursor,
      String? title,
      String? startDate,
      String? endDate,
      String? version) async {
    final services = GetIt.I.get<ReportService>();

    late RepositoriesResponse response;

    try {
      await services
          .searchListReport(basePath.contentType, basePath.accept, token,
              cursor, title, startDate, endDate, version)
          .then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: 200, dataResponse: value);
      });
    } catch (e) {
      if (e is IOException) {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 0, dataResponse: e.toString());
        print(' exception ${e}');
      }
      if (e is DioException) {
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response?.data['message'].toString() ??
                'Please check your connection..');
        print('dio exception ${e}');
      }
    }
    return response;
  }

  Future<RepositoriesResponse> searchListReport(
      String token,
      String? cursor,
      String? title,
      String? startDate,
      String? endDate,
      String? version) async {
    final services = GetIt.I.get<ReportService>();

    late RepositoriesResponse response;

    try {
      await services
          .searchListReport(basePath.contentType, basePath.accept, token,
              cursor, title, startDate, endDate, version)
          .then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: 200, dataResponse: value);
      });
    } catch (e) {
      if (e is IOException) {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 0, dataResponse: e.toString());
      }
      if (e is DioException) {
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response?.data['message'].toString() ??
                'Please check your connection..');
      }
    }
    return response;
  }

  Future<RepositoriesResponse> insertViewer(
      String token, String idReport) async {
    final services = GetIt.I.get<ReportService>();

    late RepositoriesResponse response;

    try {
      var idReportJson = {'id_report': idReport, 'version': versi};
      print('insert viewer ');
      await services
          .insertViewer(
              basePath.contentType, basePath.accept, token, idReportJson)
          .then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: 200, dataResponse: value);
      });
      print('insert viewer sucess');
    } catch (e) {
      if (e is IOException) {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 0, dataResponse: e.toString());
      }
      if (e is DioException) {
        print('insert exception ${e}');
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response?.data['message'].toString() ??
                'Please check your connection..');
      }

      print('insert viewer failed ${e.toString()}');
    }
    return response;
  }

  Future<RepositoriesResponse> getSalesReport(
      String token, ReportSalesBody reportBody) async {
    final services = GetIt.I.get<ReportService>();
    late RepositoriesResponse response;

    try {
      await services
          .getSalesReport(basePath.contentType, basePath.accept, reportBody)
          .then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: 200, dataResponse: value);
      });
    } catch (e) {
      log('Sales Report Error: ${e.toString()}');
      if (e is IOException) {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 0, dataResponse: e.toString());
      }

      if (e is DioException) {
        log('DioException Response: ${e.response?.data}');
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response?.data['message'].toString() ??
                'Please check your connection..');
      }
    }
    return response;
  }

  Future<RepositoriesResponse> getStore(
      String token, SalesDataStore store) async {
    final services = GetIt.I.get<ReportService>();
    late RepositoriesResponse response;
    try {
      await services
          .getStore(basePath.contentType, basePath.accept, store)
          .then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: 200, dataResponse: value);
      });
    } catch (e) {
      log('error store data: ${e.toString()}');
      if (e is IOException) {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 0, dataResponse: e.toString());
      }

      if (e is DioException) {
        log('DioException Response: ${e.response?.data}');
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response?.data['message'].toString() ??
                'Please check your connection..');
      }
    }
    return response;
  }

  Future<RepositoriesResponse> getReportDynamic(
      String token, ReportModel report_id) async {
    final services = GetIt.I.get<ReportService>();
    late RepositoriesResponse response;

    print("cek body: ${report_id.toJson()}"); 

    try {
      final value = await services.getReportdynamic(
          basePath.contentType, basePath.accept,report_id);

      print("Response dari API: ${value.toJson()}"); 

      response = RepositoriesResponse(
          isSuccess: true, statusCode: 200, dataResponse: value);
    } catch (e) {
      print("ke TRY $e");

      if (e is DioException) {
        print("Error dari Dio: ${e.response?.data}");

        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode ?? 500,
            dataResponse: e.response?.data['message'].toString() ??
                'Please check your connection..');
      } else {
        print("ke else tyr");

        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      }
    }
    log("message get isSuccess: ${response.isSuccess}, statusCode: ${response.statusCode}, dataResponse: ${response.dataResponse.toString()}");

    return response;
  }


 Future<RepositoriesResponse> getReportDynamicHeader(
      String token) async {
    final services = GetIt.I.get<ReportService>();
    late RepositoriesResponse response;
    try {
      final value = await services.getReportdynamicHeader(
          basePath.contentType, basePath.accept);
      response = RepositoriesResponse(
          isSuccess: true, statusCode: 200, dataResponse: value);
    } catch (e) {
      if (e is DioException) {
        print("Error dari Dio: ${e.response?.data}");
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode ?? 500,
            dataResponse: e.response?.data['message'].toString() ??
                'Please check your connection..');
      } else {
        print("ke else tyr");
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      }
    }
    log("message get isSuccess: ${response.isSuccess}, statusCode: ${response.statusCode}, dataResponse: ${response.dataResponse.toString()}");

    return response;
  }



  
}

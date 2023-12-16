import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/service/surat_jalan_service.dart';

import '../model/login_body.dart';
import '../model/repositories_response.dart';
import '../model/scan_sj_body.dart';

class SuratJalanRepositories {
  Future<RepositoriesResponse> getScanTracking(String noSJ) async {
    final services = GetIt.I.get<SuratJalanService>();

    late RepositoriesResponse response;

    try {
      await services.getScanTracking(noSJ).then((value) {
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

  Future<RepositoriesResponse> postTracking(
      TrackingSJBody body, int trackType) async {
    final services = GetIt.I.get<SuratJalanService>();

    late RepositoriesResponse response;

    try {
      if (trackType == 1) {
        await services.postTrackingDefault(body).then((value) {
          response = RepositoriesResponse(
              isSuccess: true, statusCode: value.status, dataResponse: value);
        });
      }
      if (trackType == 2) {
        await services.postTrackingStoreline(body).then((value) {
          response = RepositoriesResponse(
              isSuccess: true, statusCode: value.status, dataResponse: value);
        });
      }
      if (trackType == 3) {
        await services.postTrackingSupplier(body).then((value) {
          response = RepositoriesResponse(
              isSuccess: true, statusCode: value.status, dataResponse: value);
        });
      }
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

  Future<RepositoriesResponse> trackSJ(String noSJ) async {
    final services = GetIt.I.get<SuratJalanService>();

    late RepositoriesResponse response;

    try {
      await services.trackSJ(noSJ).then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: value.status, dataResponse: value);
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
            dataResponse: e.response!.data['message'].toString());
      }
    }

    return response;
  }
}

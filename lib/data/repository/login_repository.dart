import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;

import '../model/create_my_log_body.dart';
import '../model/login_body.dart';
import '../model/repositories_response.dart';
import '../service/login_service.dart';

class LoginRepositories {
  Future<RepositoriesResponse> login(LoginBody body) async {
    final services = GetIt.I.get<LoginService>();

    late RepositoriesResponse response;

    try {
      await services.login(body).then((value) {
        response = RepositoriesResponse(isSuccess: true, statusCode: value.status, dataResponse: value);
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

        debugPrint(e.response?.data['message'] ?? 'Failed');
      }
    }
    return response;
  }

  Future<RepositoriesResponse> getDataCustomer(String token, String userId) async {
    final services = GetIt.I.get<LoginService>();

    late RepositoriesResponse response;

    try {
      await services.getDataCustomer(basePath.contentType, basePath.accept, token, userId).then((value) {
        response = RepositoriesResponse(isSuccess: true, statusCode: value.status, dataResponse: value);
      });
    } catch (e) {
      if (e is DioError) {
        response = RepositoriesResponse(isSuccess: false, statusCode: e.response?.statusCode, dataResponse: e.response!.data.toString());
      } else {
        response = RepositoriesResponse(isSuccess: false, statusCode: 500, dataResponse: e.toString());
      }
    }
    return response;
  }
Future<RepositoriesResponse> createLog(CreateLogBody body) async {
    final services = GetIt.I.get<LoginService>();

    // Inisialisasi response dengan nilai default
    RepositoriesResponse response = RepositoriesResponse(
      isSuccess: false,
      statusCode: 500, // Default ke 500 jika terjadi error
      dataResponse: "Unknown error occurred",
    );

    try {
      await services.createLog(body).then((value) {
        response = RepositoriesResponse(
          isSuccess: true,
          statusCode: value.status,
          dataResponse: value,
        );
      });
    } catch (e) {
      if (e is DioError) {
        response = RepositoriesResponse(
          isSuccess: false,
          statusCode:
              e.response?.statusCode ?? 500, // Gunakan default jika null
          dataResponse:
              e.response?.data?.toString() ?? "Error response is null",
        );
      } else {
        response = RepositoriesResponse(
          isSuccess: false,
          statusCode: 500,
          dataResponse: e.toString(),
        );
      }
    }

    return response;
  }

  Future<RepositoriesResponse> logout() async {
    final services = GetIt.I.get<LoginService>();

    late RepositoriesResponse response;

    try {
      await services.logout().then((value) {
        response = RepositoriesResponse(isSuccess: true, statusCode: value.status, dataResponse: value);
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
            dataResponse: 'Please check your connection..');

      }
    }
    return response;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../../service/SP_service/SP_service.dart';
import '../model/create_my_log_body.dart';
import '../model/login_body.dart';
import '../model/repositories_response.dart';
import '../service/login_service.dart';
import 'package:dio/dio.dart';

class LoginRepositories {
  Future<RepositoriesResponse> login(LoginBody body) async {
    final services = GetIt.I.get<LoginService>();

    late RepositoriesResponse response;

    try {
      await services.login(body).then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: value.status, dataResponse: value);
      });
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          response = RepositoriesResponse(
              isSuccess: false,
              statusCode: e.response?.statusCode,
              dataResponse: e.response!.data['message'].toString());
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              isSuccess: false,
              statusCode: e.response?.statusCode,
              dataResponse: e.response!.data['message'].toString());
        }
      }
      if (e is IOException) {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      }
    }
    return response;
  }

  Future<RepositoriesResponse> getDataCustomer(String userId) async {
    final services = GetIt.I.get<LoginService>();

    late RepositoriesResponse response;

    try {
      await services.getDataCustomer(userId).then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: value.status, dataResponse: value);
      });
    } catch (e) {
      if (e is DioError) {
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response!.data.toString());
      } else {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      }
    }
    return response;
  }

  Future<RepositoriesResponse> createLog(CreateLogBody body) async {
    final services = GetIt.I.get<LoginService>();

    late RepositoriesResponse response;

    try {
      await services.createLog(body).then((value) {
        response = RepositoriesResponse(
            isSuccess: true, statusCode: value.status, dataResponse: value);
      });
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 400) {
          response = RepositoriesResponse(
              isSuccess: false,
              statusCode: e.response?.statusCode,
              dataResponse: e.response!.data.toString());
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              isSuccess: false,
              statusCode: e.response?.statusCode,
              dataResponse: e.response!.data.toString());
        }
      } else {
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      }
    }
    return response;
  }
}

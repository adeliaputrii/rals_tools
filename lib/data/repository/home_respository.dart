import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/service/home_app_service.dart';
import '../../service/SP_service/SP_service.dart';
import '../model/create_my_log_body.dart';
import '../model/login_body.dart';
import '../model/repositories_response.dart';
import '../service/login_service.dart';
import 'package:dio/dio.dart';

class HomeRepositories {
  Future<RepositoriesResponse> getTaskUser() async {
    final services = GetIt.I.get<HomeAppService>();

    late RepositoriesResponse response;

    try {
      await services.getTaskUser().then((value) {
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

        debugPrint(e.response!.data['message']);
      }
    }
    return response;
  }
}

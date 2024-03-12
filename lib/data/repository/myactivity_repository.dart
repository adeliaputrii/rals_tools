import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/model/myactivity_body.dart';
import 'package:myactivity_project/data/model/myactivity_edit_body.dart';
import 'package:myactivity_project/data/model/myactivity_update_body.dart';
import 'package:myactivity_project/data/service/myactivity_service.dart';
import '../model/repositories_response.dart';
import 'package:dio/dio.dart';

class MyActivityRepositories {
  Future<RepositoriesResponse> getProject() async {
    final services = GetIt.I.get<MyActivityService>();

    late RepositoriesResponse response;

    try {
      await services.getProject().then((value) {
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

  Future<RepositoriesResponse> getTaskById(String projectId) async {
    final services = GetIt.I.get<MyActivityService>();

    late RepositoriesResponse response;

    try {
      await services.getTaskById(projectId).then((value) {
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

    Future<RepositoriesResponse> submitActivity(MyActivityBody myActivityBody) async {
    final services = GetIt.I.get<MyActivityService>();

    late RepositoriesResponse response;

    try {
      await services.submitActivity(myActivityBody).then((value) {
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


    Future<RepositoriesResponse> updateActivity(MyActivityUpdateBody myActivityUpdateBody) async {
    final services = GetIt.I.get<MyActivityService>();

    late RepositoriesResponse response;

    try {
      await services.updateActivity(myActivityUpdateBody).then((value) {
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

  Future<RepositoriesResponse> editActivity(MyActivityEditBody myActivityeditBody) async {
    final services = GetIt.I.get<MyActivityService>();

    late RepositoriesResponse response;

    try {
      await services.editActivity(myActivityeditBody).then((value) {
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

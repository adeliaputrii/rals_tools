import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import 'package:myactivity_project/data/model/lspb_form_body.dart';
import 'package:myactivity_project/data/model/repositories_response.dart';
import 'package:myactivity_project/data/service/lspb_service.dart';

class LspbRepositories {
  Future<RepositoriesResponse> postFormLspb(String token, LspbFormBody body) async {
    final services = GetIt.I.get<LspbService>();
    late RepositoriesResponse response;
    try {
      await services.postFormLspb(basePath.contentType, basePath.accept, token, body).then((value) {
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

  Future<RepositoriesResponse> getTypeDoc(String token, String scan_documen, String user) async {
    final services = GetIt.I.get<LspbService>();
    late RepositoriesResponse response;
    try {
      await services.getTypeDoc(basePath.contentType, basePath.accept, token, scan_documen, user).then((value) {
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

   Future<RepositoriesResponse> getViewResquest(String token, String scan_documen, String user, String store) async {
    final services = GetIt.I.get<LspbService>();
    late RepositoriesResponse response;
    try {
      await services.getViewLspb(basePath.contentType, basePath.accept, token, scan_documen, user, store).then((value) {
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

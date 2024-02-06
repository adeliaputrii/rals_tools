import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/model/approval_return_body.dart';
import 'package:myactivity_project/data/model/repositories_response.dart';
import 'package:myactivity_project/data/service/approval_return_service.dart';

class ApprovalReturnRepositories {
  Future<RepositoriesResponse?> getDataMember(ApprovalReturnBody body) async {
    final services = GetIt.I.get<ApprovalReturnService>();

    late RepositoriesResponse response;

    try {
      await services.getDataMember(body).then((value) {
        debugPrint('success repo');
        response = RepositoriesResponse(
            isSuccess: true, statusCode: value.status, dataResponse: value);
      });
    } catch (e) {
      if (e is DioException) {
        debugPrint('dio repo');
        response = RepositoriesResponse(
            isSuccess: false,
            statusCode: e.response?.statusCode,
            dataResponse: e.response!.data['message'].toString());
      }
      if (e is IOException) {
        debugPrint('io repo');
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 500, dataResponse: e.toString());
      } else {
        debugPrint('else repo');
        response = RepositoriesResponse(
            isSuccess: false, statusCode: 0, dataResponse: e.toString());
      }
    }

    return response;
  }
}
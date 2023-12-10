import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/service/id_cash_service.dart';
import 'package:myactivity_project/data/service/surat_jalan_service.dart';

import '../model/data_member_card_body.dart';
import '../model/login_body.dart';
import '../model/repositories_response.dart';

class IDCashRepositories {
  Future<RepositoriesResponse?> getDataMember(DataMemberCardBody idUser) async {
    final services = GetIt.I.get<IDCashService>();

    late RepositoriesResponse response;

    try {
      await services.getDataMember(idUser).then((value) {
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

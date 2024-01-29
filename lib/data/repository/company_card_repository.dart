import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../model/company_card_history_body.dart';
import '../model/repositories_response.dart';
import '../service/company_card_service.dart';

class CompanyCardRepositories {
  Future<RepositoriesResponse?> getDataMember(String idUser) async {
    final services = GetIt.I.get<CompanyCardService>();

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

  Future<RepositoriesResponse?> getDetailCard(String idUser) async {
    final services = GetIt.I.get<CompanyCardService>();

    late RepositoriesResponse response;

    try {
      await services.getDetailCard(idUser).then((value) {
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

  Future<RepositoriesResponse?> getHistory(
      CompanyCardHistoryBody body, int typeHistory) async {
    final services = GetIt.I.get<CompanyCardService>();

    late RepositoriesResponse response;

    try {
      if (typeHistory == 1) {
        //GET HISTORY LATEST
        await services.getHistoryMember(body).then((value) {
          debugPrint('success repo');
          response = RepositoriesResponse(
              isSuccess: true, statusCode: value.status, dataResponse: value);
        });
      }
      if (typeHistory == 2) {
        //GET HISTORY YEAR
        await services.getHistoryMemberYear(body).then((value) {
          debugPrint('success repo');
          response = RepositoriesResponse(
              isSuccess: true, statusCode: value.status, dataResponse: value);
        });
      }
      if (typeHistory == 3) {
        //GET HISTORY MONTH
        await services.getHistoryMemberMonth(body).then((value) {
          debugPrint('success repo');
          response = RepositoriesResponse(
              isSuccess: true, statusCode: value.status, dataResponse: value);
        });
      }
      if (typeHistory == 4) {
        //GET HISTORY DAYS
        await services.getHistoryMemberDay(body).then((value) {
          debugPrint('success repo');
          response = RepositoriesResponse(
              isSuccess: true, statusCode: value.status, dataResponse: value);
        });
      }
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

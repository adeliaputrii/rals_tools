import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myactivity_project/data/model/company_card_history_body.dart';
import 'package:myactivity_project/data/model/company_card_response.dart';
import 'package:myactivity_project/data/repository/id_cash_repository.dart';
import '../../data/model/company_card_detail_response.dart';
import '../../data/model/company_card_history_days_response.dart';
import '../../data/model/company_card_history_month_response.dart';
import '../../data/model/company_card_history_response.dart';
import '../../data/model/company_card_history_year_response.dart';
import '../../data/repository/company_card_repository.dart';

part 'company_card_state.dart';

class CompanyCardCubit extends Cubit<CompanyCardState> {
  CompanyCardCubit() : super(CompanyCardInitial());

  final CompanyCardRepositories repositories = CompanyCardRepositories();
  final IDCashRepositories idCashRepositories = IDCashRepositories();

  void getDataMember(String noKartu) async {
    emit(CompanyCardLoading());

    Map<String, dynamic> requestData = {
      'nokartu': noKartu,
    };
    String requestBody = json.encode(requestData);

    await repositories.getDataMember(requestBody).then((value) {
      if (value != null) {
        if (value.isSuccess && value.dataResponse is CompanyCardResponse) {
          final res = value.dataResponse as CompanyCardResponse;
          emit(CompanyCardSuccess(res));
          debugPrint('Success cubit' + res.toString());
        } else {
          emit(CompanyCardFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      } else {
        debugPrint('value null');
      }
    });
  }

  void getDetailCard(String noKartu) async {
    emit(CompanyCardLoading());

    Map<String, dynamic> requestData = {
      'nokartu': noKartu,
    };
    String requestBody = json.encode(requestData);

    await repositories.getDetailCard(requestBody).then((value) {
      if (value != null) {
        if (value.isSuccess &&
            value.dataResponse is CompanyCardDetailResponse) {
          final res = value.dataResponse as CompanyCardDetailResponse;
          emit(CompanyCardDetailSuccess(res));
          debugPrint('Success cubit' + res.toString());
        } else {
          emit(CompanyCardFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      } else {
        debugPrint('value null');
      }
    });
  }

  void getHistoryMember(String noKartu) async {
    emit(CompanyCardLoading());
    final body = CompanyCardHistoryBody(nokartu: noKartu);
    await repositories.getHistory(body, 1).then((value) {
      if (value != null) {
        if (value.isSuccess &&
            value.dataResponse is CompanyCardHistoryResponse) {
          final res = value.dataResponse as CompanyCardHistoryResponse;
          emit(CompanyCardHistorySuccess(res));
          debugPrint('Success cubit history success' + res.toString());
        } else {
          emit(CompanyCardFailure(message: value.dataResponse!));
          debugPrint('Failed cubit' + value.dataResponse);
        }
      } else {
        debugPrint('value null');
      }
    });
  }

  void getHistoryMemberYear(String noKartu) async {
    emit(CompanyCardLoading());
    final body = CompanyCardHistoryBody(nokartu: noKartu);
    await repositories.getHistory(body, 2).then((value) {
      if (value != null) {
        if (value.isSuccess &&
            value.dataResponse is CompanyCardHistoryYearResponse) {
          final res = value.dataResponse as CompanyCardHistoryYearResponse;
          emit(CompanyCardHistoryYearSuccess(res));
          debugPrint('Success cubit' + res.toString());
        } else {
          emit(CompanyCardFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      } else {
        debugPrint('value null');
      }
    });
  }

  void getHistoryMemberMonth(String noKartu, String year) async {
    emit(CompanyCardLoading());
    final body = CompanyCardHistoryBody(nokartu: noKartu, year: year);

    await repositories.getHistory(body, 3).then((value) {
      if (value != null) {
        if (value.isSuccess &&
            value.dataResponse is CompanyCardHistoryMonthResponse) {
          final res = value.dataResponse as CompanyCardHistoryMonthResponse;
          emit(CompanyCardHistoryMonthSuccess(res));
          debugPrint('Success cubit' + res.toString());
        } else {
          emit(CompanyCardFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      } else {
        debugPrint('value null');
      }
    });
  }

  void getHistoryMemberDays(String noKartu, String year, String month) async {
    emit(CompanyCardLoading());
    final body =
        CompanyCardHistoryBody(nokartu: noKartu, year: year, month: month);

    await repositories.getHistory(body, 4).then((value) {
      if (value != null) {
        if (value.isSuccess &&
            value.dataResponse is CompanyCardHistoryResponse) {
          final res = value.dataResponse as CompanyCardHistoryResponse;
          emit(CompanyCardHistoryDaySuccess(res));
          debugPrint('Success cubit' + res.toString());
        } else {
          emit(CompanyCardFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      } else {
        debugPrint('value null');
      }
    });
  }
}

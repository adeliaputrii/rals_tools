import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myactivity_project/data/model/company_card_response.dart';
import 'package:myactivity_project/data/repository/id_cash_repository.dart';
import '../../data/repository/company_card_repository.dart';

part 'company_card_state.dart';

class CompanyCardCubit extends Cubit<CompanyCardState> {
  CompanyCardCubit() : super(CompanyCardInitial());

  final CompanyCardRepositories repositories = CompanyCardRepositories();
  final IDCashRepositories idCashRepositories = IDCashRepositories();

  void getDataMember(String noKartu) async {
    emit(CompanyCardLoading());
    // Create a Map to represent the JSON payload
    Map<String, dynamic> requestData = {
      'nokartu': noKartu,
      // Add other fields if needed
    };

    // Encode the Map as a JSON string
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
}

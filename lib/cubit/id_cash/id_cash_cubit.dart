import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/model/data_customer_response.dart';
import 'package:myactivity_project/data/model/data_member_card_response.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';

import '../../data/model/create_my_log_body.dart';
import '../../data/model/data_member_card_body.dart';
import '../../data/model/surat_jalan_response.dart';
import '../../data/repository/id_cash_repository.dart';
import '../../data/repository/surat_jalan_repository.dart';
import '../../service/SP_service/SP_service.dart';
import '../../utils/logging.dart';

part 'id_cash_state.dart';

class IDCashCubit extends Cubit<IDCashState> {
  IDCashCubit() : super(IDCashInitial());

  final IDCashRepositories repositories = IDCashRepositories();

  void getDataMember(DataMemberCardBody idUser) async {
    emit(IDCashLoading());
    await repositories.getDataMember(idUser).then((value) {
      if (value != null) {
        if (value.isSuccess && value.dataResponse is DataMemberCardResponse) {
          final res = value.dataResponse as DataMemberCardResponse;
          emit(IDCashSuccess(res));
          debugPrint('Success cubit' + res.toString());
        } else {
          emit(IDCashFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      } else {
        debugPrint('value null');
      }
    });
  }
}

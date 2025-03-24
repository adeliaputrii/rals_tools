import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myactivity_project/data/model/data_member_card_response.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';

import '../../data/model/data_member_card_body.dart';
import '../../data/repository/id_cash_repository.dart';

part 'id_cash_state.dart';

class IDCashCubit extends Cubit<IDCashState> {
  IDCashCubit() : super(IDCashInitial());

  final IDCashRepositories repositories = IDCashRepositories();

  void getDataMember(String token, DataMemberCardBody idUser) async {
    emit(IDCashLoading());
    await repositories.getDataMember(token, idUser).then((value) {
      if (value != null) {
        if (value.isSuccess && value.dataResponse is DataMemberCardResponse) {
          final res = value.dataResponse as DataMemberCardResponse;
          if (res.data != null && res.data!.isNotEmpty) {
            SharedPref.setMember('${res.data!.first.nokartu}');
            emit(IDCashSuccess(res));
            debugPrint('Success cubit: ${res.toString()}');
          } else {
            emit(IDCashFailure(message: "Data member kosong"));
            debugPrint("Data member kosong");
          }

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

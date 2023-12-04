import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/model/data_customer_response.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';

import '../../data/model/create_my_log_body.dart';
import '../../data/model/surat_jalan_response.dart';
import '../../data/repository/surat_jalan_repository.dart';
import '../../service/SP_service/SP_service.dart';
import '../../utils/logging.dart';

part 'surat_jalan_state.dart';

class SuratJalanCubit extends Cubit<SuratJalanState> {
  SuratJalanCubit() : super(SuratJalanInitial());

  final SuratJalanRepositories repositories = SuratJalanRepositories();

  final _repo = SuratJalanRepositories();

  void getScanTracking(String noSJ) async {
    emit(SuratJalanLoading());
    await repositories.getScanTracking(noSJ).then((value) {
      if (value!.isSuccess && value.dataResponse is SuratJalanResponse) {
        final res = value.dataResponse as SuratJalanResponse;
        emit(SuratJalanSuccess(res));
        debugPrint('Success' + res.toString());
      } else {
        emit(SuratJalanFailure(message: value.dataResponse!));
        debugPrint('Failed' + value.dataResponse);
      }
    });
  }
}

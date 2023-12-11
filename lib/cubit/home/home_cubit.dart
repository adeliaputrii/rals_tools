import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myactivity_project/data/model/data_member_card_response.dart';
import 'package:myactivity_project/data/model/get_task_response.dart';
import 'package:myactivity_project/data/repository/home_respository.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';

import '../../data/model/data_member_card_body.dart';
import '../../utils/logging.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final HomeRepositories repositories = HomeRepositories();

  void getTaskUser() async {
    emit(HomeLoading());
    await repositories.getTaskUser().then((value) {
      if (value != null) {
        if (value.isSuccess && value.dataResponse is GetTaskResponse) {
          final res = value.dataResponse as GetTaskResponse;
          emit(HomeSuccess(res));
          debugPrint('Success cubit' + res.toString());
        } else {
          emit(HomeFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      } else {
        debugPrint('value null');
      }
    });
  }
}

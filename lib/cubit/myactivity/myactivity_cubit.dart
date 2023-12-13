import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myactivity_project/data/model/myactivity_task_response.dart';
import 'package:myactivity_project/data/model/myactvitity_project_response.dart';
import '../../data/repository/myactivity_repository.dart';

part 'myactivity_state.dart';

class MyActivityCubit extends Cubit<MyActivityState> {
  MyActivityCubit() : super(MyActivityInitial());

  final MyActivityRepositories repositories = MyActivityRepositories();

  void getProject() async {
    emit(MyActivityLoading());
    await repositories.getProject().then((value) {
      if (value != null) {
        if (value.isSuccess && value.dataResponse is GetProjectResponse) {
          final res = value.dataResponse as GetProjectResponse;
          emit(MyActivitySuccess(res));
          debugPrint('Success cubit' + res.toString());
        } else {
          emit(MyActivityFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      } else {
        debugPrint('value null');
      }
    });
  }

  void getTaskById(String projectId) async {
    emit(MyActivityLoading());
    await repositories.getTaskById(projectId).then((value) {
      if (value != null) {
        if (value.isSuccess && value.dataResponse is MyActivityTaskResponse) {
          final res = value.dataResponse as MyActivityTaskResponse;
          emit(MyActivitySuccessTask(res));
          debugPrint('Success cubit' + res.toString());
        } else {
          emit(MyActivityFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      } else {
        debugPrint('value null');
      }
    });
  }
}

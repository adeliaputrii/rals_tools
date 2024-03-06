import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myactivity_project/data/model/myactivity_body.dart';
import 'package:myactivity_project/data/model/myactivity_edit_response.dart';
import 'package:myactivity_project/data/model/myactivity_response.dart';
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

  void submitactivity(MyActivityBody body) async {
  emit(MyActivityLoading());
  await repositories.submitActivity(body).then((value) {
    if (value != null) {
      if (value.isSuccess && value.dataResponse is MyActivityResponse) {
        final res = value.dataResponse as MyActivityResponse;
        emit(MyActivitySuccessSubmit(res));
        debugPrint('Success Submit: $res');
      } else {
        emit(MyActivityFailure(message: value.dataResponse.toString()));
        debugPrint('Failed' + value.dataResponse.toString());
      }
    } else {
      debugPrint('value is null');
    }
  });
}

  void editactivity(String body) async {
  emit(MyActivityLoading());
  await repositories.editActivity(body).then((value) {
    if (value != null) {
      if (value.isSuccess && value.dataResponse is MyActivityEditResponse) {
        final res = value.dataResponse as MyActivityEditResponse;
        emit(MyActivityEditSuccess(res));
        debugPrint('Success Submit: $res');
      } else {
        emit(MyActivityFailure(message: value.dataResponse.toString()));
        debugPrint('Failed' + value.dataResponse.toString());
      }
    } else {
      debugPrint('value is null');
    }
  });
}

}

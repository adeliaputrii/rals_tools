import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/model/approval_return_body.dart';
import 'package:myactivity_project/data/model/approval_return_response.dart';
import 'package:myactivity_project/data/repository/approval_return_repository.dart';

part 'approval_return_state.dart';

class ApprovalReturnCubit extends Cubit<ApprovalReturnState> {
  ApprovalReturnCubit() : super(ApprovalReturnInitial());

  final ApprovalReturnRepositories repositories = ApprovalReturnRepositories();

  void getDataMember({required ApprovalReturnBody idUser}) async {
    emit(ApprovalReturnLoading());
    await repositories.getDataMember(idUser).then((value) {
      if (value != null) {
        if (value.isSuccess && value.dataResponse is ApprovalReturnResponse) {
          final res = value.dataResponse as ApprovalReturnResponse;
          emit(ApprovalReturnSuccess(res));
          debugPrint('Success cubit' + res.toString());
        } else {
          emit(ApprovalReturnFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      } else {
        debugPrint('value null');
      }
    });
  }
}
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:myactivity_project/data/model/data_customer_response.dart';
import 'package:myactivity_project/data/model/login_response.dart';
import 'package:myactivity_project/tools/settingsralstools.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/create_my_log_body.dart';
import '../../data/model/login_body.dart';
import '../../data/repository/login_repository.dart';
import '../../service/SP_service/SP_service.dart';
import '../../utils/logging.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final LoginRepositories repositories = LoginRepositories();

  final _repo = LoginRepositories();
  UserData userData = UserData();

  void login({required LoginBody loginBody}) async {
    emit(LoginLoading());
    await repositories.login(loginBody).then((value) {
      if (value.isSuccess && value.dataResponse is LoginResponse) {
        final res = value.dataResponse as LoginResponse;
        userData.setDataUser(res);
        SharedPref.setToken(res.accessToken ?? '');

        emit(LoginSuccess(res));
      } else {
        emit(LoginFailure(message: value.dataResponse!));
      }
    });
  }

  void getDataCustomer(String userId) async {
    emit(GetCustomerLoading());
    await repositories.getDataCustomer(userId).then((value) {
      print('Cubit test Failure');
      if (value.isSuccess && value.dataResponse is DataCustomerResponse) {
        final res = value.dataResponse as DataCustomerResponse;
        emit(GetCustomerSuccess(res));
      } else {
        emit(GetCustomerFailure(message: value.dataResponse.toString()));
      }
    });
  }

  void createLog(
      String logInfoScreen, String? logInfoDesc, String urlApi) async {
    final userId = await SharedPref.getUserId();
    final userToko = await SharedPref.getUserToko();
    final deviceId = await SharedPref.getDeviceId();
    final deviceName = await SharedPref.getDeviceName();
    final currentDt = DateTime.now();

    final bodyLog = CreateLogBody(
        userid: int.parse(userId ?? "0"),
        devicename: deviceId,
        dateRun: currentDt.toString(),
        info1: logInfoScreen,
        info2: logInfoDesc,
        progname: urlApi,
        token: logToken,
        toko: userToko,
        versi: versi);

    emit(CreateLogLoading());
    await repositories.createLog(bodyLog).then((value) {
      if (value.isSuccess) {
        emit(CreateLogSuccess());
      } else {
        emit(CreateLogFailure(message: value.dataResponse.toString()));
      }
    });
  }

    void createLogVoidOffline(
      String? logInfoScreen, String? logInfoDesc, String urlApi, String? currentDt) async {
    final userId = await SharedPref.getUserId();
    final userToko = await SharedPref.getUserToko();
    final deviceId = await SharedPref.getDeviceId();
    final deviceName = await SharedPref.getDeviceName();

    final bodyLog = CreateLogBody(
        userid: int.parse(userId ?? "0"),
        devicename: deviceId,
        dateRun: currentDt.toString(),
        info1: logInfoScreen,
        info2: logInfoDesc,
        progname: urlApi,
        token: logToken,
        toko: userToko,
        versi: versi);

    emit(CreateLogLoading());
    await repositories.createLog(bodyLog).then((value) {
      if (value.isSuccess) {
        emit(CreateLogSuccess());
      } else {
        emit(CreateLogFailure(message: value.dataResponse.toString()));
      }
    });
  }
}

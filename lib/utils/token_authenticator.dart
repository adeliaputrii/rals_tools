import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myactivity_project/main.dart';
import 'package:myactivity_project/utils/app_navigator.dart';
import 'package:myactivity_project/utils/popup_widget.dart';

import '../widget/Login/import.dart';

class TokenAuthenticator extends Interceptor {
  final Dio dio;
  final BuildContext context;
  final GlobalKey<NavigatorState> navigatorKey;
  TokenAuthenticator(this.dio, this.context, this.navigatorKey);
  @override
  Future onError(DioException e, ErrorInterceptorHandler? handler) async {
    if (e.response?.statusCode == 401) {
      if (e.response?.statusMessage is String && e.response?.statusMessage == 'unauthenticated') {}

      PopUpWidget(context).showToastMessage('Anda harus login kembali');
      navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_) {
        return MyApp(
          loginSession: "",
          loginOfflineTime: "",
        );
      }));
      return null;
    }
    return handler!.next(e);
  }
}

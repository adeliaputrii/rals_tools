import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/utils/app_navigator.dart';
import 'package:myactivity_project/utils/popup_widget.dart';

class TokenAuthenticator extends Interceptor {
  final Dio dio;
  final BuildContext context;
  TokenAuthenticator(this.dio, this.context);
  @override
  Future onError(DioException e, ErrorInterceptorHandler handler) async {
    if (e.response?.statusCode == 401) {
      if (e.response?.statusMessage is String && e.response?.statusMessage == 'unauthenticated') {}

      PopUpWidget(context).showToastMessage('Anda harus login kembali');
      AppNavigator.navigateToLogin(context);
      return handler.resolve(await dio.fetch(e.requestOptions));
    }
    return handler.next(e);
  }
}

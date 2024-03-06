import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class AppUtils {
  final getIt = GetIt.instance;

  void initNetwork(BuildContext context) {
    final options = BaseOptions(headers: {Headers.contentTypeHeader: Headers.multipartFormDataContentType});

    final dio = Dio(options);

    // GetIt.I.registerSingleton<Dio>(dio);
    getIt.registerSingleton<Dio>(dio);
    getIt.registerSingleton<BuildContext>(context);
  }
}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class AppUtils {
  final getIt = GetIt.instance;

  void initNetwork() {
    final options = BaseOptions(headers: {Headers.contentTypeHeader: Headers.multipartFormDataContentType});

    final dio = Dio();

    // GetIt.I.registerSingleton<Dio>(dio);
    getIt.registerSingleton<Dio>(dio);
  }
}

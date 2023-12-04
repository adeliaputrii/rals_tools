import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/service/login_service.dart';
import 'package:myactivity_project/data/service/surat_jalan_service.dart';
import 'package:myactivity_project/utils/dio_interceptor.dart';

class AppServices {
  final Dio dio;

  AppServices(this.dio);

  final get = GetIt.I;

  registerAppServices(String url) async {
    dio.interceptors.clear();

    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        error: true));
    dio.interceptors.add(DioInterceptor());

    if (!get.isRegistered<LoginService>()) {
      get.registerFactory(() => LoginService(dio, baseUrl: url));
    } else {
      get.unregister<LoginService>();
      get.registerFactory(() => LoginService(dio, baseUrl: url));
    }
    if (!get.isRegistered<SuratJalanService>()) {
      get.registerFactory(() => SuratJalanService(dio, baseUrl: url));
    } else {
      get.unregister<SuratJalanService>();
      get.registerFactory(() => SuratJalanService(dio, baseUrl: url));
    }
  }
}

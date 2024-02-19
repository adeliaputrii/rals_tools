import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/service/company_card_service.dart';
import 'package:myactivity_project/data/service/id_cash_service.dart';
import 'package:myactivity_project/data/service/login_service.dart';
import 'package:myactivity_project/data/service/myactivity_service.dart';
import 'package:myactivity_project/data/service/surat_jalan_service.dart';
import 'package:myactivity_project/utils/dio_interceptor.dart';

import '../data/service/home_app_service.dart';

class AppServices {
  final Dio dio;

  AppServices(this.dio);

  final get = GetIt.I;

  registerAppServices(String url, String urlTMS) async {
    dio.interceptors.clear();

    dio.options.receiveTimeout = Duration(milliseconds: 35000);
    dio.options.connectTimeout = Duration(milliseconds: 30000);
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true, requestHeader: true, error: true));
    dio.interceptors.add(DioInterceptor());

    if (!get.isRegistered<LoginService>()) {
      get.registerFactory(() => LoginService(dio, baseUrl: url));
    } else {
      get.unregister<LoginService>();
      get.registerFactory(() => LoginService(dio, baseUrl: url));
    }
    if (!get.isRegistered<SuratJalanService>()) {
      get.registerFactory(() => SuratJalanService(dio, baseUrl: urlTMS));
    } else {
      get.unregister<SuratJalanService>();
      get.registerFactory(() => SuratJalanService(dio, baseUrl: urlTMS));
    }

    if (!get.isRegistered<IDCashService>()) {
      get.registerFactory(() => IDCashService(dio, baseUrl: url));
    } else {
      get.unregister<IDCashService>();
      get.registerFactory(() => IDCashService(dio, baseUrl: url));
    }

    if (!get.isRegistered<HomeAppService>()) {
      get.registerFactory(() => HomeAppService(dio, baseUrl: url));
    } else {
      get.unregister<HomeAppService>();
      get.registerFactory(() => HomeAppService(dio, baseUrl: url));
    }

    if (!get.isRegistered<MyActivityService>()) {
      get.registerFactory(() => MyActivityService(dio, baseUrl: url));
    } else {
      get.unregister<MyActivityService>();
      get.registerFactory(() => MyActivityService(dio, baseUrl: url));
    }

    if (!get.isRegistered<CompanyCardService>()) {
      get.registerFactory(() => CompanyCardService(dio, baseUrl: url));
    } else {
      get.unregister<CompanyCardService>();
      get.registerFactory(() => CompanyCardService(dio, baseUrl: url));
    }
  }
}

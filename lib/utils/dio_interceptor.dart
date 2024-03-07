import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPref.getToken().then((value) => options.headers[auth] = 'Bearer ${value}');
    options.headers[contentType] = appJson;
    options.headers[accept] = appJson;
    super.onRequest(options, handler);
  }
}

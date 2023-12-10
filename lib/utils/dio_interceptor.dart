import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPref.getToken()
        .then((value) => options.headers[auth] = 'aBearer ${value}');
    options.headers[contentType] = appJson;
    super.onRequest(options, handler);
  }
}

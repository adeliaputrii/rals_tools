// import 'package:dio/dio.dart';
// import 'package:myactivity_project/base/base_params.dart';
// import 'package:myactivity_project/utils/app_shared_pref.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DioInterceptor extends Interceptor {
//   @override
//   Future<void> onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final device = SharedPref.getDeviceId();
//     SharedPref.getToken()
//         .then((value) => options.headers[auth] = 'bareer : ${value}${device}');
//     options.headers[contentType] = appJson;
//     super.onRequest(options, handler);
//   }
// }

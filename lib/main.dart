import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/firebase/firebase_api.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/service/notification/notification_service.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';
import 'package:myactivity_project/utils/token_authenticator.dart';
import 'package:myactivity_project/widget/Login/import.dart';
import 'package:myactivity_project/widget/My%20List%20Task/import.dart';
import 'package:myactivity_project/widget/Splashscreen/import.dart';
import 'package:myactivity_project/widget/VOID/import.dart';
import 'package:myactivity_project/widget/import.dart';
import 'package:native_id/native_id.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:myactivity_project/tools/settingsralstools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import 'firebase/firebase_api_new.dart';
import 'firebase_options.dart';
import 'utils/app_cubit.dart';
import 'utils/app_services.dart';
import 'utils/app_utils.dart';

final navigatorKey = GlobalKey<NavigatorState>();
String _nativeId = 'Unknown';
final _nativeIdPlugin = NativeId();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  app_name = packageInfo.appName;
  String packageName = packageInfo.packageName;
  versi = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  debugPrint('appVersion ' + versi);
  await NotificationPermissions.requestNotificationPermissions;
  await NotificationPermissions.getNotificationPermissionStatus();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await Firebase.initializeApp();
  await FirebaseApiNew().initNotification();
  initPlatformState();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // String formattedDate = '2024-03-04';
  UserData userData = UserData();
  await userData.getPref();

  var waktuLoginOffline = prefs.getString("waktuLoginOffline");
  final lastLogin = await SharedPref.getLastLogin();
  final deviceId = await SharedPref.getDeviceId();
  DateTime dateTime = DateTime.parse(lastLogin ?? '${formattedDate}');
  final sevenDays = DateFormat('yyyy-MM-dd').format(dateTime.add(const Duration(days: 7)));

  debugPrint('last login : ${dateTime}');
  debugPrint('seven days logout : ${sevenDays}');
  if (formattedDate == sevenDays || DateTime.now().isAfter(dateTime.add(const Duration(days: 7)))) {
    await SharedPref.clearLastLogin();
    await SharedPref.clearUserId();
  }
  await NotificationService.initializeNotification();
  final appCubit = AppCubit();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp(loginSession: lastLogin ?? '', loginOfflineTime: waktuLoginOffline ?? '')
      // lastLogin == formattedDate ? appCubit.initCubit(HomeMainApp()) : appCubit.initCubit(SplashHomeMainApp(loginOffline: waktuLoginOffline))));
      // lastLogin != null ? appCubit.initCubit(HomeMainApp()) : appCubit.initCubit(SplashHomeMainApp(loginOffline: waktuLoginOffline))
      ));
}

Future<void> registerAppServices(BuildContext context) async {
  final appUtil = AppUtils();
  appUtil.initNetwork(context);
  final appServices = AppServices(GetIt.I.get<Dio>(), GetIt.I.get<BuildContext>());

  final url = '${basePath.base_url_dev}';
  await appServices.registerAppServices(url);
}

void firebaseInit() async {}

Future<void> initPlatformState() async {
  DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
  AndroidDeviceInfo info = await devicePlugin.androidInfo;
  String udid;
  String nativeId;
  String uuid;
  // Platform messages may fail, so we use a try/catch PlatformException.
  // We also handle the message potentially returning null.
  try {
    nativeId = await _nativeIdPlugin.getId() ?? 'Unknown NATIVE_ID';
  } on PlatformException {
    nativeId = 'Failed to get native id.';
  }

  try {
    uuid = await _nativeIdPlugin.getUUID() ?? 'Unknown UUID';
  } on PlatformException {
    uuid = 'Failed to get uuid.';
  }
  SharedPref.setDeviceId('${nativeId}${info.device}');
  SharedPref.setDeviceName('${info.brand}');
  debugPrint('device id ${nativeId}${info.device}');
}

class HomeMainApp extends StatelessWidget {
  const HomeMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.autoScale(600, name: PHONE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
        ],
      ),
      routes: {RamayanaMyListTask.route: ((context) => const RamayanaMyListTask()), RamayanaLogin.route: ((context) => const RamayanaLogin())},
      title: '${app_name}',
      debugShowCheckedModeBanner: false,
      home: DefaultBottomBarController(child: Ramayana()),
      // home: RamayanaLoginOffline(),
    );
  }
}

class SplashHomeMainApp extends StatelessWidget {
  SplashHomeMainApp({super.key, required this.loginOffline});
  final String? loginOffline;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return MaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(
              child,
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.autoScale(600, name: PHONE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
              ],
            ),
        title: '${app_name}',
        debugShowCheckedModeBanner: false,
        routes: {RamayanaMyListTask.route: ((context) => const RamayanaMyListTask()), RamayanaLogin.route: ((context) => const RamayanaLogin())},
        home: loginOffline == formattedDate ? RamayanaVoid(isOffline: true) : SplashScreenRamayana());
  }
}

class MyApp extends StatelessWidget {
  final String loginSession;
  final String loginOfflineTime;

  MyApp({Key? key, required this.loginSession, required this.loginOfflineTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        RamayanaMyListTask.route: (context) => const RamayanaMyListTask(),
        RamayanaLogin.route: (context) => const RamayanaLogin(),
      },
      home: FutureBuilder(
        future: _initApp(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildHome(context);
          } else {
            // You can return a loading indicator while initialization is in progress
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _initApp(BuildContext context) async {
    registerAppServices(context);
  }

  Widget _buildHome(BuildContext context) {
    final appCubit = AppCubit(); // Assuming this is your cubit instance
    final lastLogin = loginSession; // Get the last login time
    final waktuLoginOffline = loginOfflineTime; // Get the offline login time

    return lastLogin.isNotEmpty ? appCubit.initCubit(HomeMainApp()) : appCubit.initCubit(SplashHomeMainApp(loginOffline: waktuLoginOffline));
  }
}

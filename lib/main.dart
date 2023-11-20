
import 'dart:async';
import 'dart:io';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:myactivity_project/firebase/firebase_api.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/service/notification/notification_service.dart';
import 'package:myactivity_project/widget/Splashscreen/import.dart';
import 'package:myactivity_project/widget/import.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:background_fetch/background_fetch.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await NotificationPermissions.requestNotificationPermissions;
  await NotificationPermissions.getNotificationPermissionStatus();
  await Permission.notification.isDenied.then((value) {
        if (value) {
          Permission.notification.request();
        }
      });
      await Firebase.initializeApp();
    await FirebaseApi().initNotification();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  print(formattedDate);
  UserData userData = UserData();
  await userData.getPref();
  String userId = userData.getUsernameID();
  print('grgr 123');
  print(userId);
  var username = prefs.getString("username");
  
  print(" username : ${username}");
  var waktuLogin = prefs.getString("waktuLogin");
  print("waktu login : ${waktuLogin}");
  await NotificationService.initializeNotification();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
       waktuLogin == formattedDate
                ? HomeMainApp()
                : SplashHomeMainApp()
                ));
}
class HomeMainApp extends StatelessWidget {
  const HomeMainApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
      navigatorKey: navigatorKey,
      title: 'rals-tools',
        debugShowCheckedModeBanner: false,
      
      home: DefaultBottomBarController(child: Ramayana()),
    );
  }
}

class SplashHomeMainApp extends StatelessWidget {
  const SplashHomeMainApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
      navigatorKey: navigatorKey,
      title: 'rals-tools',
        debugShowCheckedModeBanner: false,
      
      home: SplashScreenRamayana()
    );
  }
}

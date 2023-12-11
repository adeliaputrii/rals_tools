import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:myactivity_project/widget/Login/import.dart';
import 'package:myactivity_project/widget/My%20List%20Task/import.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../utils/check_session.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Message Id: ${message.messageId}');
  print('Title: ${message.data["title"]}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApiNew {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) async {
    CheckSession checkSession = CheckSession();
    if (message == null) return;
    debugPrint('test fcm');
    debugPrint(checkSession.checkSession().toString());
    if (await checkSession.checkSession()) {
      navigatorKey.currentState
          ?.pushNamed(RamayanaMyListTask.route, arguments: message);
    } else {
      navigatorKey.currentState
          ?.pushNamed(RamayanaLogin.route, arguments: message);
    }
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token ${fCMToken}');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
  }
}
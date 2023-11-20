import 'dart:convert';

import'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myactivity_project/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload : ${message.data}');
}

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'View more new task',
    importance: Importance.defaultImportance
    );
    final _localNotifications = FlutterLocalNotificationsPlugin();
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // HomeMainApp.navigatorKey.currentState?.push(
    //     MaterialPageRoute(
    //       builder: (_) => RamayanaMyListTask()
    //     ),
    //   );
  }

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const setting = InitializationSettings(android: android);

    await _localNotifications.initialize(
      setting,
      onSelectNotification : (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload!));
        handleMessage(message);
      }
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
      await platform?.createNotificationChannel(_androidChannel);
    
  }
  Future initPushNotifications()async {
    await FirebaseMessaging.instance.
      setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true
      );
      FirebaseMessaging.instance.getInitialMessage().then((handleMessage));
      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      FirebaseMessaging.onMessage.listen((message) {
          final notification = message.notification;
            if(notification == null) return;

            _localNotifications.show(
              notification.hashCode, 
              notification.title, 
              notification.body, 
              NotificationDetails(
                android: AndroidNotificationDetails(
                  _androidChannel.id,
                  _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@drawable/ic_launcher',

                )
                ),
                payload: jsonEncode(message.toMap())
              );
      });
  }

  Future<void> initNotification() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _firebaseMessaging.requestPermission();
    var fcmToken = await _firebaseMessaging.getToken();
    var tokenFirebase = prefs.setString('firebaseToken', fcmToken == null ? '' : fcmToken);
    print('Token : ${fcmToken}');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
    initLocalNotification();
  }
}
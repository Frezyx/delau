import 'package:delau/utils/notification/notification_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final notifications = FlutterLocalNotificationsPlugin();

  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        showOngoingNotification(notifications, title: 'fgfg', body: 'Body');
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
    );
  }

  // Future<dynamic> myBackgroundMessageHandler(
  //     Map<String, dynamic> message) async {
  //   debugPrint("background: $message");
  //   //_showNotification(NotificationModel.......(message),
  //   return Future<void>.value();
  // }

  // Future<dynamic> foregroundMessageHandler(Map<String, dynamic> message) async {
  //   debugPrint("foreground: $message");
  //   //_showNotification(NotificationModel.......(message),
  // }
}

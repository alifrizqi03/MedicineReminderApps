import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

initializeNotif() async {
  final fcm = FirebaseMessaging.instance;

  try {
    if (Platform.isAndroid) {
      await fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      await fcm.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((event) {});
      FirebaseMessaging.onBackgroundMessage((message) async {});
      FirebaseMessaging.onMessageOpenedApp.listen((event) {});
      FirebaseMessaging.onMessage.listen(_onMessage);
      FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_onopened);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  final message = await fcm.getInitialMessage();

  if (message != null) {
    final data = message.data;
    debugPrint("Pesan $data");
  }
  debugPrint(
      "Token : ${(await FirebaseMessaging.instance.getToken()).toString()}");
}

//handler foreground
void _onMessage(RemoteMessage message) {
  debugPrint("Pesan 1 ${message.notification?.title}");
  debugPrint("${message.notification?.body}");
}

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  debugPrint("Pesan 2 ${message.notification?.title}");
  debugPrint("${message.notification?.body}");
}

// handler ketika klik
void _onopened(RemoteMessage message) async {
  final data = message.data;
  debugPrint("ter klik $data");
}

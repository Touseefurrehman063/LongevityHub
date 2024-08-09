// ignore_for_file: unused_local_variable, unused_field

import 'dart:math' as dm;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:longevity_hub/data/localDB/local_db.dart';

class NotificationsServicesRepo {
  final _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

// final _messageStreamController = BehaviorSubject<RemoteMessage>();

  Future<void> initNotifications() async {
    FirebaseMessaging fcm = FirebaseMessaging.instance;
    await fcm.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    String? token = await fcm.getToken();
    if (token != null) {
      await LocalDb().saveDeviceToken(token);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await handleBackgroundMessage(message);
    });
  }

  Future<void> showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        dm.Random.secure().nextInt(100000).toString(),
        'High Importance Notification');
    AndroidNotificationDetails details = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'Ticker',
      // ignore: prefer_const_constructors
    );

    DarwinNotificationDetails darwin = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notifs =
        NotificationDetails(android: details, iOS: darwin);

    Future.delayed(Duration.zero, () {
      _plugin.show(0, message.notification?.title.toString(),
          message.notification?.body.toString(), notifs);
      // log(message.data.toString());
    });
  }

  Future<void> showBackgroundNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        dm.Random.secure().nextInt(100000).toString(),
        'High Importance Notification');
    AndroidNotificationDetails details = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'Ticker',
      // ignore: prefer_const_constructors
    );

    DarwinNotificationDetails darwin = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notifs =
        NotificationDetails(android: details, iOS: darwin);

    Future.delayed(Duration.zero, () {
      _plugin.show(0, message.notification?.title.toString(),
          message.notification?.body.toString(), notifs);
      // log(message.data.toString());
    });
  }

  firebaseInit() {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((message) async {
      // log(message.notification!.body.toString());
      // log(message.data.toString());
      await showNotifications(message);
    });
  }

  initLocalNotifications() async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var init = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _plugin.initialize(
      init,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await showBackgroundNotifications(message);
    if (message.notification?.title.toString().toLowerCase() == "calling") {
      final Iterable<Duration> pauses = [
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
      ];

      // Get.to(() => Ringerscreen(
      //       data: model,
      //     )
    }
  }
}

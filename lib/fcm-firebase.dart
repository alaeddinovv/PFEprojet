import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/main.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/home/home.dart';
import 'package:pfeprojet/screen/JoueurScreens/home/home.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';

Future<void> handleBackgroudMessage(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Payload: ${message.data}");
  // print('dsdsdsdsdsd');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );
  final _LocalNotifications = FlutterLocalNotificationsPlugin();
  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    } else {
      final data = message.data;
      final screenName = data['screen'];

      switch (screenName) {
        case 'gg':
          EquipeCubit.get(navigatorKey.currentContext)
              .getEquipeInvite()
              .then((value) {
            HomeJoueurCubit.get(navigatorKey.currentContext)
                .changeIndexNavBar(3);
            EquipeCubit.get(navigatorKey.currentContext).changeTogelButton(3);
            navigatorKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeJoueur()),
                (route) => false);
          });
        case 'fetchReservationsAdmin':
          HomeAdminCubit.get(navigatorKey.currentContext).changeIndexNavBar(1);
          navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeAdmin()),
              (route) => false);

          break;
      }
    }

    //  else if (message.notification!.title == 'equipe') {
    //   navigatorKey.currentState?.push(
    //       MaterialPageRoute(builder: (context) => const ProfileJoueur()));
    // }
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
    FirebaseMessaging.onBackgroundMessage(handleBackgroudMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _LocalNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            importance: _androidChannel.importance,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _LocalNotifications.initialize(settings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      final message =
          RemoteMessage.fromMap(jsonDecode(notificationResponse.payload!));
      handleMessage(message);
    });
    final platform = _LocalNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    fCMToken = await _firebaseMessaging.getToken();
    print("fCMToken: $fCMToken");
    initPushNotifications();
    initLocalNotifications();
  }
}

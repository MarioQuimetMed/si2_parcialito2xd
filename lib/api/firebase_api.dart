import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _mensajesStreamController = StreamController<String>.broadcast();
  final _notifications = FlutterLocalNotificationsPlugin();

// Inicializa las configuraciones de Android.
  var androidInitialize = AndroidInitializationSettings('app_icon');

// Inicializa las configuraciones para ambas plataformas.

  Stream<String> get mensajesStream => _mensajesStreamController.stream;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    Future<void> _showNotification(String? title, String? body) async {
      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          showWhen: false);
      const platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await _notifications.show(0, title ?? 'Unknown title',
          body ?? 'Unknown body', platformChannelSpecifics,
          payload: 'item x');
    }

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    FirebaseMessaging.onMessage.listen((event) {
      _showNotification(event.notification?.title, event.notification?.body);
      // final String data = event.data['MatterID'];
      final String? data = event.data.toString();
      if (data == null) {
        // Maneja el caso en que 'MatterID' sea null
      } else {
        _mensajesStreamController.sink.add(data);
        print('onMessage');
        print(event.data);

        print(event.notification?.body);
        _mensajesStreamController.sink.add(data);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('onMessageOpenedApp');
      print(event.notification?.body);
      _mensajesStreamController.add(event.notification?.body ?? 'No data');
    });

    final FCMtoken = await _firebaseMessaging.getToken();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('FCMtoken', FCMtoken!);
    print('FCMtoken: $FCMtoken');
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}

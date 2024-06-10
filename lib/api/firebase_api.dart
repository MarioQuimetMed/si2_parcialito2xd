import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final FCMtoken = await _firebaseMessaging.getToken();

    print('FCMtoken: $FCMtoken');
  }
}

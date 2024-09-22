import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notifications/services/local_notification_service.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    //1_ permission
    await messaging.requestPermission();
    //2_ Fcm token to send to server
    // String? token =
    await messaging.getToken().then((value) {
      sendTokenToServer(value!);
    });
    //send token to server if refreshed
    messaging.onTokenRefresh.listen(sendTokenToServer);

    // log(token ?? 'no token');
    //1_ first status is notification in background and when i killed application
    FirebaseMessaging.onBackgroundMessage(
        handleBackGroundMessage); //need function to handle background
    //2_ when app is in foreground(app is opened)
    handleForegroundMessage();
    //subscribe topic to send notification to all users
    messaging.subscribeToTopic('all');
    //when user log out from app and need to unsubscribe from topic
    messaging.unsubscribeFromTopic('all');
  }

  static Future<void> handleBackGroundMessage(
      RemoteMessage remoteMessage) async {
    await Firebase.initializeApp();
    log(remoteMessage.notification?.title ?? 'no title');
    //log('handleBackGroundMessage: $remoteMessage');
  }

  static void sendTokenToServer(String token) {}
}

void handleForegroundMessage() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //show local notification
    LocalNotificationService.showBasicNotification(message);
  });
}

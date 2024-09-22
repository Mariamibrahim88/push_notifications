import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:push_notifications/app/app.dart';
import 'package:push_notifications/firebase_options.dart';
import 'package:push_notifications/services/local_notification_service.dart';
import 'package:push_notifications/services/push_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //to improve perfomance it takes time of the longest service

  await Future.wait([
    LocalNotificationService.init(),
    PushNotificationsService.init(),
  ]);
  // PushNotificationsService.init();
  // LocalNotificationService.init();

  runApp(const PushNotifications());
}

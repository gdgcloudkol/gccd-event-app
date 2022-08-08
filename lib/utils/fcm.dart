import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

Future<void> setForegroundMessageListener(
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  AndroidNotificationChannel channel,
) async {
  await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
            ),
          ));
    }
  });
}

Future<void> setupInteractedMessage(NavigationBloc nb) async {
  /// Get any messages which caused the application to open from
  /// a terminated state.
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  /// Handle any interaction when the app is in the background via a
  /// Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

void _handleMessage(RemoteMessage message) {
  if (message.data.containsKey(Config.fcmArgRedirect)) {
    launchUrlString(
      message.data[Config.fcmArgRedirect],
      mode: LaunchMode.externalApplication,
    );
  } else if (message.data[Config.fcmArgScreen] == 'speakers') {
    print("Here");
  }
}

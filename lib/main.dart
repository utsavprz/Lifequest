import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lifequest/app/app.dart';
import 'package:lifequest/helper/object_box.dart';
import 'package:lifequest/state/objectbox_state.dart';

// ?CUID 11495686
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print("Handling a background message: ${message.messageId}");
}

final container = ProviderContainer();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  // print('User granted permission: ${settings.authorizationStatus}');

  AwesomeNotifications().initialize(
    'resource://drawable/launcher',
    [
      NotificationChannel(
          channelGroupKey: 'lifequest_channel_group',
          channelKey: 'lifequest_channel',
          channelName: 'Lifequest notification',
          channelDescription: 'Notification channel for lifequest',
          defaultColor: Colors.red,
          importance: NotificationImportance.Max,
          ledColor: Colors.white,
          channelShowBadge: true),
    ],
  );

  // await ObjectBoxInstance.deleteDatabase();
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();

  // Disable Landscape mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

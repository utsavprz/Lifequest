import 'package:flutter/material.dart';
import 'package:lifequest/app/routes.dart';
import 'package:lifequest/screens/wearos/wear_login.dart';
import 'package:lifequest/theme/theme_data.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Lifequest',
      debugShowCheckedModeBanner: false,
      initialRoute: WearLogin.route,
      routes: getAppRoutes,
      theme: getApplicationTheme(context),
    );
  }
}

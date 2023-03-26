import 'package:flutter/cupertino.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const String route = 'NotificationScreen';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('Notification screen'),
      ),
    );
  }
}

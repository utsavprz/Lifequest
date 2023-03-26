import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class SendNotification {
  static void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAwM1l37M:APA91bFY47EKcsKSymmDqWZRQBFjTJqFMKM8p3DlNS7wqkzq89ZU5QGH4fTNm1AbRX4lM-tw-2g8QCFCQ-LF2Ox8DHzW0KLqR7P-eB2N44r_Su0vLarJ_WMH9BhwDiCjJ80BTGY7IsRG'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "lifequest_channel"
            },
            "to": token
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
  }
}

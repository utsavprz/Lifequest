import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/models/user_blood_request.dart';
import 'package:lifequest/providers/blood_requests_provider.dart';
import 'package:lifequest/providers/user_provider.dart';
import 'package:lifequest/repository/blood_request_repo.dart';
import 'package:lifequest/screens/request_accepter_screen.dart';

import '../main.dart';

class BloodRequestCard extends StatefulWidget {
  final UserBloodRequest bloodRequest;

  const BloodRequestCard(this.bloodRequest, {super.key});

  @override
  State<BloodRequestCard> createState() => _BloodRequestCardState();
}

class _BloodRequestCardState extends State<BloodRequestCard> {
  final _gap = const SizedBox(
    height: 8,
  );

  final _smallGap = const SizedBox(
    height: 3,
  );
  void sendPushNotification(String token, String body, String title,
      Map<String, dynamic> data) async {
    try {
      http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAQiIwcN4:APA91bHPxjrfvz7CJBeaxnjP8WlgujovN-2B_I8Nan5FZ5kbN6s-Mc0NGH0zl4APz5HsMt4hLv--bjz_Drplc-FjMYxG5k7XhbQz1eN2u0nubdkWGUIP57UALpHpe6nGxM26cCtugkr0'
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
              'notificationData': data
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "lifequest_channel"
            },
            "to": token,
          }));
    } on Exception {
      if (kDebugMode) {
        print("error in notification");
      }
    }
  }

  void _showConfirmationDialog(String requestId, String requestUserId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text(
              "Are you sure you want to accept this request? The request can't be cancelled later on"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () async {
                // print(requestId);
                // print('requestUserId: $requestUserId');
                SharedPref.setString('requestStatus', 'Pending');
                SharedPref.setString('notificationData', requestUserId);
                BloodRequestRepositoryImpl().updateUserBloodRequest(
                  requestId,
                  {
                    'status': "Pending",
                    "donor": container.read(userProvider)!.id
                  },
                ).then((value) async {
                  container
                      .read(bloodRequestProvider.notifier)
                      .currentRequestId = requestId;
                  DocumentSnapshot<Map<String, dynamic>> snap =
                      await FirebaseFirestore.instance
                          .collection("UserTokens")
                          .doc(requestUserId)
                          .get();

                  String msgBody =
                      '${container.read(userProvider)!.profile!.firstName} has accepted your blood request';
                  sendPushNotification(
                    snap['token'],
                    msgBody,
                    'Blood request accepted',
                    {"requestId": value!.id},
                  );
                  Navigator.of(context).pop();

                  Navigator.pushReplacementNamed(
                      context, RequestAccepterScreen.route,
                      arguments: {"request": value});
                });

                // Perform the action
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final dateFormat = DateFormat.yMMMMd();
    final timeFormat = DateFormat.jm();
    final dateTime = DateTime.tryParse(widget.bloodRequest.datetimeRequested!);
    final dateRequested =
        dateTime != null ? dateFormat.format(dateTime) : 'Invalid date format';
    final timeRequested = dateTime != null ? timeFormat.format(dateTime) : '';
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              color: Color.fromARGB(255, 214, 214, 214),
              blurRadius: 10,
            ),
          ],
        ),
        child: SizedBox(
          width: width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.bloodRequest.user!.profile!.firstName} ${widget.bloodRequest.user!.profile!.lastName} ',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Raleway SemiBold'),
                  ),
                  _gap,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Blood Group Requested : ',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.bloodRequest.bloodType.toString(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      _smallGap,
                      Row(
                        children: [
                          const Text(
                            'Hospital : ',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${widget.bloodRequest.hospital!.name}',
                            // 'name',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      _smallGap,
                      Row(
                        children: [
                          const Text(
                            'Requested Date : ',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            dateRequested,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      _smallGap,
                      Row(
                        children: [
                          const Text(
                            'Requested Time : ',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            timeRequested,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    child: IconButton(
                      onPressed: () {
                        // print('${widget.bloodRequest.id}');
                        _showConfirmationDialog(
                            widget.bloodRequest.id.toString(),
                            widget.bloodRequest.user!.id.toString());
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/models/user_blood_request.dart';
import 'package:intl/intl.dart';
import 'package:lifequest/providers/blood_requests_provider.dart';
import 'package:lifequest/utils/countdown_timer.dart';
import 'package:http/http.dart' as http;

class RequestAccepterScreen extends StatefulWidget {
  const RequestAccepterScreen({super.key});

  static const String route = "RequestAccepterScreen";
  @override
  State<RequestAccepterScreen> createState() => _RequestAccepterScreenState();
}

class _RequestAccepterScreenState extends State<RequestAccepterScreen> {
  UserBloodRequest? currentRequest;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments! as dynamic;
    currentRequest = args['request'];
  }

  bool _notified = false;
  final _gap = const SizedBox(
    height: 8,
  );

  final _smallGap = const SizedBox(
    height: 3,
  );
  void notifyOtherUser(String token, String body, String title,
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final dateFormat = DateFormat.yMMMMd();
    final timeFormat = DateFormat.jm();
    final dateTime = DateTime.tryParse(currentRequest!.datetimeRequested!);
    final dateRequested =
        dateTime != null ? dateFormat.format(dateTime) : 'Invalid date format';
    final timeRequested = dateTime != null ? timeFormat.format(dateTime) : '';

    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 3,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(currentRequest!.hospital!.lat!,
                  currentRequest!.hospital!.lon!), // London coordinates
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
              child: currentRequest != null
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        // borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 1),
                            color: Color.fromARGB(255, 214, 214, 214),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${currentRequest!.user!.profile!.firstName} ${currentRequest!.user!.profile!.lastName} ',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Raleway SemiBold'),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Blood Group Requested : ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            currentRequest!
                                                .user!.profile!.bloodType
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      _smallGap,
                                      Row(
                                        children: [
                                          const Text(
                                            'Hospital : ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '${currentRequest!.hospital!.name}',
                                            // 'name',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      _smallGap,
                                      Row(
                                        children: [
                                          const Text(
                                            'Requested Date : ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            dateRequested,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      _smallGap,
                                      Row(
                                        children: [
                                          const Text(
                                            'Requested Time : ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            timeRequested,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      _smallGap,
                                      Row(
                                        children: [
                                          const Text(
                                            'Phone number : ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            currentRequest!
                                                .user!.profile!.phoneNumber
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${currentRequest!.user!.profile!.firstName} was notified!',
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle),
                                      child: const Icon(Icons.person),
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.call,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Icon(
                                          Icons.message,
                                          size: 30,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const CircularProgressIndicator()),
        ),
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        'Status: ',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(currentRequest!.status.toString(),
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold))
                    ],
                  ),
                  CountdownTimer(
                      endTime: DateTime.parse(
                          currentRequest!.datetimeRequested.toString())),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: ElevatedButton(
                          onPressed: _notified == false
                              ? () async {
                                  DocumentSnapshot<Map<String, dynamic>> snap =
                                      await FirebaseFirestore.instance
                                          .collection("UserTokens")
                                          .doc(currentRequest!.user!.id)
                                          .get();
                                  notifyOtherUser(
                                      snap['token'],
                                      '${currentRequest!.donor!.profile!.firstName} is on the way',
                                      'Donor is on the way', {
                                    "requestId": container
                                        .read(bloodRequestProvider.notifier)
                                        .currentRequestId
                                  });
                                  setState(() {
                                    _notified = true;
                                  });
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            _notified == false
                                ? 'Notify that you are on the way'
                                : '${currentRequest!.user!.profile!.firstName} was notified that you are on the way',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: const Text('Dispute this request',
                            style: TextStyle(
                                fontFamily: 'Raleway Regular',
                                color: Colors.red,
                                fontSize: 12)),
                      )
                    ],
                  )
                ],
              ),
            )),
      ]),
    );
  }
}

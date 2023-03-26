// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import 'package:lifequest/app/snackbar.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/models/user_blood_request.dart';
import 'package:lifequest/providers/blood_requests_provider.dart';
import 'package:lifequest/repository/blood_request_repo.dart';
import 'package:lifequest/screens/home_main_screen.dart';

class RequestSenderScreen extends StatefulWidget {
  static const String route = "RequestSenderScreen";

  const RequestSenderScreen({super.key});

  @override
  State<RequestSenderScreen> createState() => _RequestSenderScreenState();
}

class _RequestSenderScreenState extends State<RequestSenderScreen> {
  UserBloodRequest? currentRequest;
  String requestId = '';
  List<String> statusList = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments! as dynamic;
    requestId = jsonDecode(args['requestId'])['requestId'];
    await BloodRequestRepositoryImpl()
        .getBloodRequestById(requestId)
        .then((value) {
      // print('status:${args['status']}');
      print('status:$statusList');
      setState(() {
        statusList = args['status'];
        // statusList = widget.statusList;
        print(value);
        currentRequest = value;
      });
    });
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text(
              "Are you sure you want to mark this request as donated?"),
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
                BloodRequestRepositoryImpl()
                    .addDonationRecord(requestId)
                    .then((value) async {
                  DocumentSnapshot<Map<String, dynamic>> snap =
                      await FirebaseFirestore.instance
                          .collection("UserTokens")
                          .doc(currentRequest!.donor!.id)
                          .get();
                  markAsDonated(
                      snap['token'],
                      '${currentRequest!.user!.profile!.firstName} has marked the request as donated',
                      'Request marked as donated', {
                    "requestId": container
                        .read(bloodRequestProvider.notifier)
                        .currentRequestId
                  });
                  BloodRequestRepositoryImpl().updateUserBloodRequest(
                    currentRequest!.id.toString(),
                    {
                      'status': "Donated",
                      'datetimeDonated': DateTime.now().toString()
                    },
                  ).then((value) {
                    setState(() async {
                      SharedPref.removeString('requestStatus');
                      SharedPref.removeString('notificationData');
                      Navigator.of(context).pop();
                      statusList.add('Donor has donated');
                      await showSnackbar(
                          context, 'Donor has been notified', Colors.green);

                      Navigator.pushReplacementNamed(
                          context, HomeMainScreen.route);
                    });
                  });
                });
              },
            ),
          ],
        );
      },
    );
  }

  final _gap = const SizedBox(
    height: 8,
  );

  final _smallGap = const SizedBox(
    height: 3,
  );

  void markAsDonated(String token, String body, String title,
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
    final String dateRequested;
    final String timeRequested;
    final DateTime? dateTime;

    if (currentRequest != null) {
      dateTime = DateTime.tryParse(currentRequest!.datetimeRequested!);
      dateRequested = dateTime != null
          ? dateFormat.format(dateTime)
          : 'Invalid date format';
      timeRequested = dateTime != null ? timeFormat.format(dateTime) : '';
    } else {
      dateRequested = '';
      timeRequested = '';
      dateTime = DateTime.now();
    }
    return Scaffold(
        body: currentRequest != null
            ? Column(children: [
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
                      child: Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${currentRequest!.donor!.profile!.firstName} ${currentRequest!.donor!.profile!.lastName} ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Raleway SemiBold'),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              .donor!.profile!.bloodType
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
                                  '${currentRequest!.donor!.profile!.firstName} has accepted your request!',
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
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
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
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Text(currentRequest!.status.toString(),
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(
                            height: 110,
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.green[400],
                                          shape: BoxShape.circle),
                                    ),
                                    Container(
                                      width: 3,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: statusList
                                                .contains('Donor is on the way')
                                            ? Colors.green[400]
                                            : const Color.fromARGB(
                                                255, 180, 180, 180),
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: statusList.contains(
                                                  'Donor is on the way')
                                              ? Colors.green[400]
                                              : const Color.fromARGB(
                                                  255, 180, 180, 180),
                                          shape: BoxShape.circle),
                                    ),
                                    Container(
                                      width: 3,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: statusList
                                                .contains('Donor has donated')
                                            ? Colors.green[400]
                                            : const Color.fromARGB(
                                                255, 180, 180, 180),
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: statusList
                                                  .contains('Donor has donated')
                                              ? Colors.green[400]
                                              : const Color.fromARGB(
                                                  255, 180, 180, 180),
                                          shape: BoxShape.circle),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Request Accepted',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      'Donor is on the way',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      'Donor has donated',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showConfirmationDialog();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: const Text('Mark as donated',
                                      style: TextStyle(fontSize: 13)),
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
              ])
            : const CircularProgressIndicator());
  }
}

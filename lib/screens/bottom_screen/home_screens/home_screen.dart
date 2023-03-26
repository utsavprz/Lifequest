import 'dart:async';
import 'dart:convert';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:lifequest/app/app.dart';
import 'package:lifequest/app/network_connectivity.dart';
import 'package:lifequest/app/snackbar.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/main.dart';

import 'package:lifequest/models/hospital.dart';
import 'package:lifequest/models/user_blood_request.dart';
import 'package:lifequest/providers/blood_requests_provider.dart';
import 'package:lifequest/providers/user_provider.dart';
import 'package:lifequest/repository/blood_request_repo.dart';
import 'package:lifequest/repository/user_repo.dart';
import 'package:lifequest/screens/bottom_screen/home_screens/donate_blood_screen.dart';
import 'package:lifequest/screens/bottom_screen/home_screens/donors_screen.dart';
import 'package:lifequest/screens/bottom_screen/home_screens/hospital_near_you.dart';
import 'package:lifequest/screens/home_main_screen.dart';
import 'package:lifequest/screens/login_screen.dart';
import 'package:lifequest/screens/registration_screen/success_screen.dart';
import 'package:lifequest/screens/request_sender_screen.dart';
import 'package:lifequest/utils/blood_group_selector.dart';
import 'package:lifequest/utils/blood_request_card.dart';
import 'package:lifequest/utils/greeting_text.dart';
import 'package:lifequest/utils/homepage_cards.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:shake/shake.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String route = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Place> _places = [];

  String? _selectedPlace;

  static Hospital? hospitalDetail;
  String? reqBloodtype;
  String? reqDateTime;
  final _emergencySelectedValue = SingleValueDropDownController();

  final _hosptialField = TextEditingController();

  double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  void initState() {
    super.initState();
    _streamSubscription.add(proximityEvents!.listen((event) {
      setState(() {
        _proximityValue = event.proximity;
        if (_proximityValue < 0) {
          SharedPref.clearSharedPref();
          Navigator.pushReplacementNamed(context, LoginScreen.route);
          print('logout');
        }
      });
    }));
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        _hospitalFieldfocusNode.requestFocus();
      },
    );

    void saveToken(String token) async {
      // User
      FirebaseFirestore.instance
          .collection("UserTokens")
          .doc(container.read(userProvider)!.id)
          .set({'email': container.read(userProvider)!.email, 'token': token});
      print(container.read(userProvider)!.email);
      print('saved');
    }

    String? mtoken;
    void getToken() async {
      await FirebaseMessaging.instance.getToken().then((token) {
        setState(() {
          mtoken = token;
          print("mtoken");
        });
        saveToken(token!);
      });
    }

    getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification!;
      // AndroidNotification? android = message.notification!.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: counter,
          channelKey: 'lifequest_channel',
          title: notification.title,
          body: notification.body,
        ),
      );
      print('notifictionTitle: ${notification.title}');
      Map<String, dynamic> data = message.data;
      if (notification.title == 'Blood request accepted') {
        SharedPref.setString('requestStatus', notification.title.toString());
        SharedPref.setString('notificationData', data['notificationData']);
        // Retrieve the data from the message
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, RequestSenderScreen.route,
              arguments: {
                'requestId': data['notificationData'],
                'status': ['Request Accepted']
              });
        });
      } else if (notification.title == 'Donor is on the way') {
        SharedPref.setString('requestStatus', notification.title.toString());
        SharedPref.setString('notificationData', data['notificationData']);
        navigatorKey.currentState
            ?.pushReplacementNamed(RequestSenderScreen.route, arguments: {
          'requestId': data['notificationData'],
          'status': ['Request Accepted', 'Donor is on the way']
        });
      } else if (notification.title == 'Request marked as donated') {
        SharedPref.removeString('requestStatus');
        SharedPref.removeString('notificationData');
        // retreive and store new blood request on after donation
        await BloodRequestRepositoryImpl().getBloodRequests().then((value) {
          container
              .read(bloodRequestProvider.notifier)
              .updateRecentBloodRequestList(value);
        });

        navigatorKey.currentState?.pushReplacementNamed(SuccessScreen.route,
            arguments: 'Thank you for donating and saving a life!');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification!.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.

      print('notifictionTitle: ${notification.title}');
      Map<String, dynamic> data = message.data;
      if (notification.title == 'Blood request accepted') {
        SharedPref.setString('requestStatus', notification.title.toString());
        SharedPref.setString('notificationData', data['notificationData']);
        // Retrieve the data from the message
        Navigator.pushReplacementNamed(context, RequestSenderScreen.route,
            arguments: {
              'requestId': data['notificationData'],
              'status': ['Request Accepted']
            });
      } else if (notification.title == 'Donor is on the way') {
        SharedPref.setString('requestStatus', notification.title.toString());
        SharedPref.setString('notificationData', data['notificationData']);
        Navigator.pushReplacementNamed(context, RequestSenderScreen.route,
            arguments: {
              'requestId': data['notificationData'],
              'status': ['Request Accepted', 'Donor is on the way']
            });
      } else if (notification.title == 'Request marked as donated') {
        SharedPref.removeString('requestStatus');
        SharedPref.removeString('notificationData');
        // retreive and store new blood request on after donation
        await BloodRequestRepositoryImpl().getBloodRequests().then((value) {
          container
              .read(bloodRequestProvider.notifier)
              .updateRecentBloodRequestList(value);
        });

        await UserRepositoryImpl()
            .getUserById(container.read(userProvider)!.id!)
            .then((value) => {
                  setState(() {
                    container.read(userProvider.notifier).setUser(value);
                  })
                });

        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, SuccessScreen.route,
              arguments: 'Thank you for donating and saving a life!');
        });
      }
    });
  }

  int counter = 1;

  showLocalNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: counter,
        channelKey: 'lifequest_channel',
        title: 'Request Sent',
        body: 'Your blood request has been sent to nearby user',
      ),
    );
    setState(() {
      counter++;
    });
  }

  Future searchPlace(String place) async {
    final places = await Nominatim.searchByName(
      query: place,
      limit: 2,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
      countryCodes: ['np'],

      // category: 'healthcare',
    );
    return places;
  }

  hospitalFieldOnTap(int index) {
    setState(() {
      _selectedPlace =
          '${_places[index].nameDetails!['name']}, ${_places[index].address!['suburb']}';
      _hosptialField.text = _selectedPlace.toString();

      hospitalDetail = Hospital(
        name: _places[index].nameDetails!['name'],
        displayName: _places[index].displayName,
        road: _places[index].address!['road'],
        neighbourhood: _places[index].address!['neighbourhood'],
        suburb: _places[index].address!['suburb'],
        lat: _places[index].lat,
        lon: _places[index].lon,
      );

      print(jsonEncode(hospitalDetail));
      _places.clear();
    });
  }

  getBloodType(String? bloodtype) {
    setState(() {
      reqBloodtype = bloodtype;
    });
  }

  final List<String> emergencyLst = [
    'Normal',
    'Critical',
  ];
  final gap = const SizedBox(
    height: 8,
  );
  final tinyGap = const SizedBox(
    height: 5,
  );

  int request = 5;
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Are you sure you want to send this request?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                _sendBloodRequest();
                // Perform the action
              },
            ),
          ],
        );
      },
    );
  }

  final List<UserBloodRequest> bloodRequestsList = [];

  final globalKey = GlobalKey<FormState>();

  _sendBloodRequest() async {
    Map<String, dynamic> hospitalLocation = {
      "type": "Point",
      "coordinates": [hospitalDetail!.lat, hospitalDetail!.lon]
    };
    print(hospitalDetail);
    print(reqBloodtype);
    print(_emergencySelectedValue.dropDownValue!.name);
    print(reqDateTime);
    print(hospitalLocation);

    UserBloodRequest bloodRequest = UserBloodRequest(
        hospital: hospitalDetail,
        bloodType: reqBloodtype,
        quantity: 5,
        urgency: _emergencySelectedValue.dropDownValue!.name,
        location: hospitalLocation,
        datetimeRequested: reqDateTime);

    int status =
        await BloodRequestRepositoryImpl().sendUserBloodRequest(bloodRequest);

    _showMessage(status);
  }

  _showMessage(int status) async {
    switch (status) {
      case 400:
        showSnackbar(
            context,
            'You cannot send another request. The previous request has to be accepted or expire',
            Colors.red);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, HomeMainScreen.route);
        });

        break;
      case 200:
        showSnackbar(context, 'Sent request to nearby doners', Colors.green);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, HomeMainScreen.route);
        });
        showLocalNotification();

        break;
      default:
        showSnackbar(context, 'Error in sending blood request', Colors.red);
    }
  }

  final FocusNode _hospitalFieldfocusNode = FocusNode();

  ShakeDetector? detector;

  @override
  void dispose() {
    detector?.stopListening();

    for (final subscription in _streamSubscription) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final user = container.read(userProvider);
    List<UserBloodRequest> bloodRequests = container.read(bloodRequestProvider);

    // BloodRequestProviders bloodRequestProvider =
    //     Provider.of<BloodRequestProviders>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: FocusScope(
        node: FocusScopeNode(),
        child: SizedBox(
            height: (height - MediaQuery.of(context).padding.top) * 1,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 20),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 214, 1, 51),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  child: Stack(
                    children: [
                      Form(
                        key: globalKey,
                        child: Column(
                          children: [
                            GreetingToUser(
                                name: user?.profile != null
                                    ? '${user?.profile!.firstName}'
                                    : 'user'),
                            gap,
                            TextFormField(
                              controller: _hosptialField,
                              focusNode: _hospitalFieldfocusNode,
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: 'Select Hospital',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ))),
                              onChanged: (value) async {
                                await NetworkConnectivity.isOnline()
                                    .then((value) {
                                  if (value == false) {
                                    _hospitalFieldfocusNode.unfocus();
                                    return showSnackbar(
                                        context,
                                        'Internet connection offline',
                                        Colors.red);
                                  }
                                });
                                // Call the API and get the data from the response
                                List<Place> responseData =
                                    await searchPlace(value);
                                setState(() {
                                  _places = responseData;
                                });
                              },
                            ),
                            tinyGap,
                            Container(
                              padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                              alignment: Alignment.topLeft,
                              child: const Text(
                                'Select blood type',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Raleway Regular',
                                ),
                              ),
                            ),
                            BloodGroupSelector(
                              getBloodType: getBloodType,
                            ),
                            gap,
                            DropDownTextField(
                              textStyle: const TextStyle(fontSize: 12),
                              textFieldDecoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: 'Select the urgency',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ))),
                              // initialValue: "name4",
                              controller: _emergencySelectedValue,
                              clearOption: true,
                              clearIconProperty:
                                  IconProperty(color: Colors.red),

                              validator: (value) {
                                if (value == null) {
                                  return "Required field";
                                } else {
                                  return null;
                                }
                              },
                              dropDownItemCount: emergencyLst.length,

                              dropDownList: emergencyLst
                                  .map((item) => DropDownValueModel(
                                      name: item, value: item))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  debugPrint(_emergencySelectedValue
                                      .dropDownValue!.name);
                                });
                              },
                            ),
                            gap,
                            DateTimeFormField(
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: 'Pick date and time',
                                  hintStyle: TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ))),
                              // firstDate: DateTime.now().add(const Duration(days: 10)),
                              // lastDate: DateTime.now().add(const Duration(days: 40)),
                              // initialDate: DateTime.now().add(const Duration(days: 20)),
                              autovalidateMode: AutovalidateMode.always,
                              validator: (DateTime? e) => (e?.day ?? 0) == 1
                                  ? 'Please not the first day'
                                  : null,
                              onDateSelected: (DateTime value) {
                                setState(() {
                                  reqDateTime = value.toString();
                                });
                                debugPrint(value.toString());
                              },
                            ),
                            gap,
                            gap,
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 76, 185, 80),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    if (_hosptialField.text.isEmpty ||
                                        _emergencySelectedValue.dropDownValue ==
                                            null ||
                                        reqBloodtype == null ||
                                        reqDateTime == null) {
                                      showSnackbar(
                                          context,
                                          'Blood donation request fields cannot be empty',
                                          Colors.red);
                                    } else {
                                      _showConfirmationDialog();
                                    }
                                  },
                                  child: const Text(
                                    "Send request to donors",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )),
                            )
                          ],
                        ),
                      ),
                      _places.isNotEmpty
                          ? Positioned(
                              width: width - 40,
                              height: height * 0.24,
                              top: 74,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView.builder(
                                  itemCount: _places.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        hospitalFieldOnTap(index);
                                      },
                                      child: Container(
                                        // margin:
                                        //     const EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                '${_places[index].nameDetails!['name']}'),
                                            Text(
                                              '${_places[index].address!['road']}, ${_places[index].address!['neighbourhood']}, ${_places[index].address!['suburb']}',
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Navigator.pushNamed(context, DonateBloodScreen.route);
                        },
                        child: const HomePageCard(
                            title: 'Donate Blood',
                            subtitle: 'Look up blood donation campaign',
                            icon: Icons.bloodtype),
                      ),
                      gap,
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, DonorsScreen.route);
                        },
                        child: const HomePageCard(
                          title: 'Donors in my area',
                          subtitle: 'Look up voluntered blood donors',
                          icon: Icons.handshake,
                        ),
                      ),
                      gap,
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, HospitalScreen.route);
                        },
                        child: const HomePageCard(
                            title: 'Hospitals near you',
                            subtitle: 'Search for nearest Hospitals',
                            icon: Icons.local_hospital),
                      ),
                    ],
                  ),
                ),
                gap,
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Recent Requests',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                gap,
                bloodRequests.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: bloodRequests.length,
                          itemBuilder: ((context, index) {
                            print(bloodRequests);
                            return Column(children: [
                              BloodRequestCard(bloodRequests[index]),
                              gap,
                            ]);
                          }),
                        ),
                      )
                    : const Expanded(
                        child: Center(child: Text('No recent blood requests')))
              ],
            )),
      )),
    );
  }
}

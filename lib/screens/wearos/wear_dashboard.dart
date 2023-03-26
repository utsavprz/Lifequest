import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:lifequest/app/network_connectivity.dart';
import 'package:lifequest/app/snackbar.dart';
import 'package:lifequest/models/hospital.dart';
import 'package:lifequest/models/user_blood_request.dart';
import 'package:lifequest/repository/blood_request_repo.dart';
import 'package:lifequest/utils/blood_group_selector.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:wear/wear.dart';

class WearDashboard extends StatefulWidget {
  const WearDashboard({super.key});

  static const String route = "WearDashboard";

  @override
  State<WearDashboard> createState() => _WearDashboardState();
}

class _WearDashboardState extends State<WearDashboard> {
  String? selectedPlace;
  List<Place> places0 = [];

  Hospital? hospitalDetail;
  String? reqBloodtype;
  String? reqDateTime;
  final emergencySelectedValue = SingleValueDropDownController();

  final hosptialField = TextEditingController();
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
      selectedPlace =
          '${places0[index].nameDetails!['name']}, ${places0[index].address!['suburb']}';
      hosptialField.text = selectedPlace.toString();

      hospitalDetail = Hospital(
        name: places0[index].nameDetails!['name'],
        displayName: places0[index].displayName,
        road: places0[index].address!['road'],
        neighbourhood: places0[index].address!['neighbourhood'],
        suburb: places0[index].address!['suburb'],
        lat: places0[index].lat,
        lon: places0[index].lon,
      );

      print(jsonEncode(hospitalDetail));
      places0.clear();
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
  static const gap = SizedBox(
    height: 8,
  );
  static const tinyGap = SizedBox(
    height: 5,
  );
  _showMessage(int status) async {
    switch (status) {
      case 400:
        showSnackbar(
            context,
            'You cannot send another request. The previous request has to be accepted or expire',
            Colors.red);

        break;
      case 200:
        showSnackbar(context, 'Sent request to nearby doners', Colors.green);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, WearDashboard.route);
        });
        showLocalNotification();

        break;
      default:
        showSnackbar(context, 'Error in sending blood request', Colors.red);
    }
  }

  _sendBloodRequest() async {
    Map<String, dynamic> hospitalLocation = {
      "type": "Point",
      "coordinates": [hospitalDetail!.lat, hospitalDetail!.lon]
    };
    print(hospitalDetail);
    print(reqBloodtype);
    print(emergencySelectedValue.dropDownValue!.name);
    print(reqDateTime);
    print(hospitalLocation);

    UserBloodRequest bloodRequest = UserBloodRequest(
        hospital: hospitalDetail,
        bloodType: reqBloodtype,
        quantity: 5,
        urgency: emergencySelectedValue.dropDownValue!.name,
        location: hospitalLocation,
        datetimeRequested: reqDateTime);

    int status =
        await BloodRequestRepositoryImpl().sendUserBloodRequest(bloodRequest);

    _showMessage(status);
  }

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

  final FocusNode hospitalFieldfocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return WatchShape(
      builder: (context, shape, child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 3, bottom: 10, top: 10),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 214, 1, 51),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                  ),
                  child: Stack(
                    children: [
                      Form(
                        key: globalKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: hosptialField,
                              focusNode: hospitalFieldfocusNode,
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
                                    hospitalFieldfocusNode.unfocus();
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
                                  places0 = responseData;
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
                              controller: emergencySelectedValue,
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
                                  debugPrint(emergencySelectedValue
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
                                    if (hosptialField.text.isEmpty ||
                                        emergencySelectedValue.dropDownValue ==
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
                      places0.isNotEmpty
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
                                  itemCount: places0.length,
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
                                                '${places0[index].nameDetails!['name']}'),
                                            Text(
                                              '${places0[index].address!['road']}, ${places0[index].address!['neighbourhood']}, ${places0[index].address!['suburb']}',
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
              ),
            );
          },
        );
      },
    );
  }
}

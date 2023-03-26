import 'package:flutter/material.dart';
import 'package:lifequest/app/snackbar.dart';
import 'package:lifequest/providers/location_provider.dart';
import 'package:lifequest/repository/blood_request_repo.dart';
import 'package:lifequest/screens/registration_screen/blood_select_screen.dart';

import '../../main.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  static const String route = 'UserInfoScreen';

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  void initState() {
    super.initState();
    container.read(locationProvider.notifier).getCurrentLocation();
  }

  final _gap = const SizedBox(
    height: 8,
  );



  final firstNameInput = TextEditingController();
  final lastNameInput = TextEditingController();
  final ageInput = TextEditingController();
  final phoneInput = TextEditingController();
  final cityInput = TextEditingController();
  final streetNameInput = TextEditingController();
  double? lat;
  double? lon;
  String? selectedGender;

  final _globalKey = GlobalKey<FormState>();

  List gender = ["Male", "Female", "Other"];

  Widget genderPicker(int btnValue, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = title;
        });
      },
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: selectedGender == title
                    ? const Color.fromARGB(255, 214, 1, 51)
                    : const Color.fromARGB(255, 231, 231, 231),
                width: 1)),
        child: title == "Male"
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.male,
                    color: selectedGender == title
                        ? const Color.fromARGB(255, 214, 1, 51)
                        : const Color.fromARGB(255, 49, 49, 49),
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            : title == "Female"
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.female,
                          color: selectedGender == title
                              ? const Color.fromARGB(255, 214, 1, 51)
                              : const Color.fromARGB(255, 49, 49, 49)),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.transgender,
                          color: selectedGender == title
                              ? const Color.fromARGB(255, 214, 1, 51)
                              : const Color.fromARGB(255, 49, 49, 49)),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
      ),
    );
  }

  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  _unfocusTextFields() {
    for (var focusNode in _focusNodes) {
      focusNode.unfocus();
    }
  }

  _sendDataToBloodSelectScreen() {
    if (_globalKey.currentState!.validate()) {
      if (selectedGender != null) {
        _unfocusTextFields();
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(context, BloodSelectScreen.route, arguments: {
            'firstName': firstNameInput.text,
            'lastName': lastNameInput.text,
            'phone': phoneInput.text,
            'age': ageInput.text,
            'gender': selectedGender,
            'city': cityInput.text,
            'streetName': streetNameInput.text,
            'lat': lat,
            'lon': lon,
          });
        });
        //
      } else {
        showSnackbar(context, 'Please select your gender', Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final location = container.read(locationProvider);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            child: FocusScope(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: height * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fill in your information',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            _gap,
                            TextFormField(
                              focusNode: _focusNodes[0],
                              controller: firstNameInput,
                              decoration: InputDecoration(
                                labelText: 'First Name',
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Fields cannot be empty';
                                }
                                return null;
                              },
                            ),
                            _gap,
                            TextFormField(
                              controller: lastNameInput,
                              focusNode: _focusNodes[1],
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Fields cannot be empty';
                                }
                                return null;
                              },
                            ),
                            _gap,
                            TextFormField(
                              controller: ageInput,
                              focusNode: _focusNodes[2],
                              decoration: InputDecoration(
                                labelText: 'Age',
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Fields cannot be empty';
                                } else {
                                  if (int.parse(val) < 17) {
                                    return 'Age must be greater than 17';
                                  }
                                  return null;
                                }
                              },
                            ),
                            _gap,
                            Text(
                              'Select Gender',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            _gap,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                genderPicker(0, 'Male'),
                                genderPicker(1, 'Female'),
                                genderPicker(2, 'Others'),
                              ],
                            ),
                            _gap,
                            TextFormField(
                              controller: phoneInput,
                              focusNode: _focusNodes[3],
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Fields cannot be empty';
                                } else {
                                  if (val.length < 10) {
                                    return 'Invalid Phone number';
                                  }
                                  return null;
                                }
                              },
                            ),
                            _gap,
                            TextFormField(
                              controller: cityInput,
                              focusNode: _focusNodes[4],
                              decoration: InputDecoration(
                                labelText: 'City',
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Fields cannot be empty';
                                }
                                return null;
                              },
                            ),
                            _gap,
                            TextFormField(
                              controller: streetNameInput,
                              focusNode: _focusNodes[5],
                              decoration: InputDecoration(
                                labelText: 'Street Name',
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Fields cannot be empty';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 45,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 214, 1, 51),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onPressed: () {
                                        print('${location.latitude}');
                                        print('${location.longitude}');
                                        setState(() {
                                          lat = location.latitude;
                                          lon = location.longitude;
                                        });
                                        _sendDataToBloodSelectScreen();
                                      },
                                      child: const Text(
                                        "Next",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

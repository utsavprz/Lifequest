import 'package:flutter/material.dart';
import 'package:lifequest/app/snackbar.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/models/user.dart';
import 'package:lifequest/models/user_profile.dart';
import 'package:lifequest/providers/user_provider.dart';
import 'package:lifequest/repository/user_repo.dart';
import 'package:lifequest/screens/registration_screen/success_screen.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../main.dart';
import '../../repository/blood_request_repo.dart';

class BloodSelectScreen extends StatefulWidget {
  const BloodSelectScreen({Key? key}) : super(key: key);

  static const String route = 'BloodSelectScreen';

  @override
  State<BloodSelectScreen> createState() => _BloodSelectScreenState();
}

class _BloodSelectScreenState extends State<BloodSelectScreen> {
  String? _selectedBloodGroup;
  dynamic args;

  _saveUserProfile() async {
    UserProfile profile = UserProfile()
      ..firstName = args['firstName']
      ..lastName = args['lastName']
      ..age = int.parse(args['age'])
      ..gender = args['gender']
      ..phoneNumber = args['phone']
      ..city = args['city']
      ..streetName = args['streetName']
      ..lat = args['lat']
      ..lon = args['lon']
      ..bloodType = _selectedBloodGroup;

    int status = await UserRepositoryImpl().addUserProfile(profile);

    _showMessage(status);
  }

  getBloodRequests() async {
    await BloodRequestRepositoryImpl().getBloodRequests();
  }

  _showMessage(int status) async {
    if (status == 1) {
      User? user = User.fromJson(await SharedPref.getMap('userMap'));
      // Provider.of<UserProvider>(context, listen: false).user = user;

      container.read(userProvider.notifier).setUser(user);

      showSnackbar(context, 'User profile created', Colors.green);

      // before navigating, retreive and store new blood request on logging in the app
      getBloodRequests();
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, SuccessScreen.route,
            arguments: '${args['firstName']}\'s profile has been created');
      });
    } else {
      showSnackbar(context, 'Error in creating user profile', Colors.red);
    }
  }

  final List _bloodGroup = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as dynamic;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/images/blood_drop.png',
                width: 100,
              ),
              const Text(
                'Select your blood type',
                style: TextStyle(
                    color: Color.fromARGB(255, 49, 49, 49),
                    fontFamily: 'Raleway SemiBold',
                    fontSize: 20),
              ),
              SizedBox(
                height: height * 0.5,
                child: GridView.count(
                    padding: const EdgeInsets.all(8),
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 20,
                    childAspectRatio: 2,
                    children: _bloodGroup
                        .map((bloodGroup) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedBloodGroup = bloodGroup.toString();
                                  debugPrint(_selectedBloodGroup);
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: _selectedBloodGroup == bloodGroup
                                        ? const Color.fromARGB(255, 214, 1, 51)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          color: Color.fromARGB(
                                              255, 211, 211, 211))
                                    ]),
                                child: Text(
                                  '$bloodGroup',
                                  style: TextStyle(
                                      fontFamily: 'Raleway Bold',
                                      fontSize: 24,
                                      color: _selectedBloodGroup == bloodGroup
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255, 49, 49, 49)),
                                ),
                              ),
                            ))
                        .toList()),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Don\'t know your blood type?',
                  style: TextStyle(
                      color: Color.fromARGB(255, 214, 1, 51),
                      fontFamily: 'Raleway SemiBold',
                      fontSize: 12),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 214, 1, 51),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      if (_selectedBloodGroup != null) {
                        _saveUserProfile();
                      } else {
                        MotionToast.error(
                          description: const Text('Select your blood type'),
                        ).show(context);
                      }
                    },
                    child: const Text(
                      "Finish",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      )),
    );
  }
}

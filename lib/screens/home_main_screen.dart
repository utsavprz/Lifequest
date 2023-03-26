import 'package:flutter/material.dart';
import 'package:lifequest/app/network_connectivity.dart';
import 'package:lifequest/data_source/local_data_source/current_user_data_source.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/models/user.dart';
import 'package:lifequest/providers/blood_requests_provider.dart';
import 'package:lifequest/repository/blood_request_repo.dart';
import 'package:lifequest/repository/user_repo.dart';
import 'package:lifequest/screens/bottom_screen/account_screens/accounts_screen.dart';
import 'package:lifequest/screens/bottom_screen/home_screens/home_screen.dart';
import 'package:lifequest/screens/bottom_screen/notifications.dart';
import 'package:lifequest/screens/registration_screen/user_info_screen.dart';
import 'dart:async';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  static const String route = 'HomeMainScreen';

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  int _selectedIndex = 0;
  String mtoken = "";
  final List<Widget> _lstScreen = [
    const HomeScreen(),
    const AccountScreen(),
  ];

  Future<bool> firstLogin() async {
    bool status = false;

    int id = await SharedPref.getInt('objectBoxId');
    User userData = await UserRepositoryImpl().getUserById(id.toString());
    // print('Profile: ${userData.profile}');
    if (userData.profile == null) {
      setState(() {
        status = true;
      });
    }
    return status;
  }

  @override
  void initState() {
    NetworkConnectivity.isOnline()
        .then((check) => {
              CurrentUserDataSource.getProfile().then((value) async {
                if (value == null) {
                  setState(() {
                    _lstScreen[0] = const UserInfoScreen();
                  });
                } else {
                   
                }
              }),
              // retreive and store new blood request on opening the app
            })
        // ignore: body_might_complete_normally_catch_error
        .catchError((err) {
      firstLogin().then((value) => {
            // print(value),
            if (value)
              {
                setState(() {
                  _lstScreen[0] = const UserInfoScreen();
                })
              }
          });
    });

    super.initState();
  }

  getBloodRequest() async {
    BloodRequestRepositoryImpl().getBloodRequests().then((value) {
      setState(() {
        container
            .read(bloodRequestProvider.notifier)
            .updateRecentBloodRequestList(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _lstScreen[_selectedIndex],
      bottomNavigationBar: Offstage(
        offstage: _lstScreen[0] is UserInfoScreen,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          selectedItemColor: Colors.red,
          unselectedItemColor: const Color.fromARGB(255, 69, 69, 69),
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lifequest/app/app.dart';
import 'package:lifequest/data_source/local_data_source/campaign_data_source.dart';
import 'package:lifequest/data_source/local_data_source/user_data_source.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/models/user.dart';
import 'package:lifequest/providers/blood_requests_provider.dart';
import 'package:lifequest/providers/user_provider.dart';
import 'package:lifequest/repository/blood_request_repo.dart';
import 'package:lifequest/repository/campaign_repo.dart';
import 'package:lifequest/repository/user_repo.dart';
import 'package:lifequest/screens/home_main_screen.dart';
import 'package:lifequest/screens/login_screen.dart';
import 'package:lifequest/screens/registration_screen/success_screen.dart';
import 'package:lifequest/screens/request_accepter_screen.dart';
import 'package:lifequest/screens/request_sender_screen.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String route = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String data = '';

  @override
  void initState() {
    _initLocationService();
    _checkNotificationEnable();
    _getTokenFromSharedPref();
    super.initState();
  }

  // _updatedUserData() {
  //   UserRepositoryImpl().getUserById(id)
  // }

  _checkNotificationEnable() {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }

  Future<Position> _initLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location services are disabled');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanenttly denied, we cannot proceed further');
    }
    print("location granted");
    return await Geolocator.getCurrentPosition();
  }

  bool isWearOS() {
    if (Platform.isAndroid) {
      return Platform.version.startsWith("2");
    }
    return false;
  }

  _getTokenFromSharedPref() async {
    String? token = await SharedPref.getTokenFromPrefs();
    if (token != null) {
      // store current user instance to userprovider
      User? user = User.fromJson(await SharedPref.getMap('userMap'));
      // Provider.of<UserProvider>(context, listen: false).user = user;
      container.read(userProvider.notifier).setUser(user);

      // await UserRepositoryImpl()
      //     .getUserById(container.read(userProvider)!.id!)
      //     .then((value) =>
      //         {container.read(userProvider.notifier).setUser(value)});
      if (await SharedPref.containsKey('requestStatus')) {
        String requestStatus = await SharedPref.getString('requestStatus');
        String notificationData =
            await SharedPref.getString('notificationData');
        if (requestStatus == "Blood request accepted") {
          print('insharedpref: Blood request accepted');
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, RequestSenderScreen.route,
              arguments: {
                'requestId': notificationData,
                'status': ['Request Accepted']
              });
        } else if (requestStatus == "Donor is on the way") {
          print('insharedpref: Donor is on the way');
          navigatorKey.currentState
              ?.pushReplacementNamed(RequestSenderScreen.route, arguments: {
            'requestId': notificationData,
            'status': ['Request Accepted', 'Donor is on the way']
          });
        } else if (requestStatus == "Request marked as donated") {
          // retreive and store new blood request on after donation
          await BloodRequestRepositoryImpl().getBloodRequests().then((value) {
            container
                .read(bloodRequestProvider.notifier)
                .updateRecentBloodRequestList(value);
          });

          navigatorKey.currentState?.pushReplacementNamed(SuccessScreen.route,
              arguments: 'Thank you for donating and saving a life!');
        } else if (requestStatus == "Pending") {
          Navigator.pushReplacementNamed(context, RequestAccepterScreen.route,
              arguments: {"request": notificationData});
        }
      } else {
        // retreive and store new blood request on opening the app
        await BloodRequestRepositoryImpl().getBloodRequests().then((value) {
          container
              .read(bloodRequestProvider.notifier)
              .updateRecentBloodRequestList(value);
        });

        await CampaignRepositoryImpl().getUserCampaign().then(
          (value) {
            print('campaign: $value');
            CampaignDataSource()
                .addCampaigns(value)
                .then((value) => print('added campaigns in objectbox: $value'));
          },
        );

        await UserRepositoryImpl().getDonors().then(
          (value) {
            // print(value[0].profile);/
            UserDataSource()
                .addDonors(value)
                .then((value) => print('added donors in objectbox: $value'));
          },
        );
        setState(() {
          data = token;

          Future.delayed(const Duration(seconds: 5), () {
            Navigator.pushReplacementNamed(context, HomeMainScreen.route);
          });
          // if (isWearOS() == true) {
          //   print(isWearOS());
          //   Future.delayed(const Duration(seconds: 5), () {
          //     Navigator.pushReplacementNamed(context, WearDashboard.route);
          //   });
          // } else {
          //   Future.delayed(const Duration(seconds: 5), () {
          //     Navigator.pushReplacementNamed(context, HomeMainScreen.route);
          //   });
          // }
        });
      }
    } else {
      setState(() {
        data = 'No Data Found';
        // if (isWearOS()) {
        //   Future.delayed(const Duration(seconds: 5), () {
        //     Navigator.pushReplacementNamed(context, WearLogin.route);
        //   });
        // } else {
        //   Future.delayed(const Duration(seconds: 5), () {
        //     Navigator.pushReplacementNamed(context, LoginScreen.route);
        //   });
        // }
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.pushReplacementNamed(context, LoginScreen.route);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 1, 51),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_whiteText.png',
              width: 220,
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}

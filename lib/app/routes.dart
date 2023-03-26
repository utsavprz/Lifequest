import 'package:flutter/cupertino.dart';
import 'package:lifequest/screens/bottom_screen/account_screens/accounts_screen.dart';
import 'package:lifequest/screens/bottom_screen/account_screens/profile_edit_screen.dart';
import 'package:lifequest/screens/bottom_screen/home_screens/donate_blood_screen.dart';
import 'package:lifequest/screens/bottom_screen/home_screens/donors_screen.dart';
import 'package:lifequest/screens/bottom_screen/home_screens/home_screen.dart';
import 'package:lifequest/screens/bottom_screen/home_screens/hospital_near_you.dart';
import 'package:lifequest/screens/bottom_screen/notifications.dart';
import 'package:lifequest/screens/donated_screen.dart';
import 'package:lifequest/screens/google_map_screen.dart';
import 'package:lifequest/screens/osm_screen.dart';
import 'package:lifequest/screens/previous_donation_record_screen.dart';
import 'package:lifequest/screens/previous_request_record_screen.dart';
import 'package:lifequest/screens/registration_screen/blood_select_screen.dart';
import 'package:lifequest/screens/login_screen.dart';
import 'package:lifequest/screens/home_main_screen.dart';
import 'package:lifequest/screens/registration_screen/success_screen.dart';
import 'package:lifequest/screens/request_sender_screen.dart';
import 'package:lifequest/screens/splash_screen.dart';
import 'package:lifequest/screens/registration_screen/user_info_screen.dart';
import 'package:lifequest/screens/registration_screen/register_screen.dart';
import 'package:lifequest/screens/wearos/wear_dashboard.dart';
import 'package:lifequest/screens/wearos/wear_login.dart';

import '../screens/request_accepter_screen.dart';

var getAppRoutes = <String, WidgetBuilder>{
  SplashScreen.route: (context) => const SplashScreen(),
  LoginScreen.route: (context) => const LoginScreen(),
  WearLogin.route: (context) => const WearLogin(),
  RegisterScreen.route: (context) => const RegisterScreen(),
  UserInfoScreen.route: (context) => const UserInfoScreen(),
  BloodSelectScreen.route: (context) => const BloodSelectScreen(),
  SuccessScreen.route: (context) => const SuccessScreen(),
  HomeMainScreen.route: (context) => const HomeMainScreen(),
  WearDashboard.route: (context) => const WearDashboard(),
  HomeScreen.route: (context) => const HomeScreen(),
  DonateBloodScreen.route: (context) => const DonateBloodScreen(),
  DonorsScreen.route: (context) => const DonorsScreen(),
  PreviousDonationRecordScreen.route: (context) =>
      const PreviousDonationRecordScreen(),
  PreviousRequestRecordScreen.route: (context) =>
      const PreviousRequestRecordScreen(),
  DonatedScreen.route: (context) => const DonatedScreen(),
  HospitalScreen.route: (context) => const HospitalScreen(),
  RequestSenderScreen.route: (context) => const RequestSenderScreen(),
  RequestAccepterScreen.route: (context) => const RequestAccepterScreen(),
  AccountScreen.route: (context) => const AccountScreen(),
  EditProfileScreen.route: (context) => const EditProfileScreen(),
  NotificationScreen.route: (context) => const NotificationScreen(),
  GoogleMapScreen.route: (context) => const GoogleMapScreen(),
  OsmScreen.route: (context) => const OsmScreen(),
};

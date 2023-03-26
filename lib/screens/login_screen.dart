import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lifequest/app/snackbar.dart';
import 'package:lifequest/data_source/local_data_source/campaign_data_source.dart';
import 'package:lifequest/data_source/local_data_source/user_data_source.dart';
import 'package:lifequest/providers/blood_requests_provider.dart';
import 'package:lifequest/providers/user_provider.dart';
import 'package:lifequest/repository/blood_request_repo.dart';
import 'package:lifequest/repository/campaign_repo.dart';
import 'package:lifequest/repository/user_repo.dart';
import 'package:lifequest/screens/home_main_screen.dart';
import 'package:lifequest/screens/registration_screen/register_screen.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String route = 'EmailLoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _gap = const SizedBox(
    height: 8,
  );

  final _emailInput = TextEditingController();

  final _passwordInput = TextEditingController();

  final _globalKey = GlobalKey<FormState>();
  int counter = 1;
  int bloodreqCount = 0;
  _login() async {
    final islogin = await UserRepositoryImpl()
        .loginUser(context, _emailInput.text, _passwordInput.text);
    if (islogin) {
      await BloodRequestRepositoryImpl().getBloodRequests().then((value) {
        setState(() {
          bloodreqCount = value.length;
        });
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

      getToken();
      // write here
      _goToAnotherPage();
      // String? token = await SharedPref.getTokenFromPrefs();
      // debugPrint(token);
    } else {
      _showMessage();
    }
  }

  _goToAnotherPage() {
    Navigator.pushReplacementNamed(context, HomeMainScreen.route);

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: counter,
        channelKey: 'lifequest_channel',
        title: ' Blood requests',
        body:
            'You have $bloodreqCount blood request',
      ),
    );
    setState(() {
      counter++;
    });
  }

  _showMessage() {
    showSnackbar(context, 'Invalid username or password', Colors.red);
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

  void saveToken(String token) async {
    // User
    FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(container.read(userProvider)!.id)
        .set({'email': container.read(userProvider)!.email, 'token': token});
    print(container.read(userProvider)!.email);
    print('saved');
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _globalKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: SizedBox(
                  width: double.infinity,
                  height: height * 0.6,
                  // decoration: const BoxDecoration(color: Colors.red),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 150,
                      ),
                      const Text(
                        'Login to your account',
                        style: TextStyle(
                            color: Color.fromARGB(255, 49, 49, 49),
                            fontFamily: 'Raleway SemiBold',
                            fontSize: 20),
                      ),
                      Column(
                        children: [
                          TextFormField(
                            controller: _emailInput,
                            decoration: InputDecoration(
                              labelText: 'Email',
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
                            controller: _passwordInput,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            obscureText: true,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Fields cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 214, 1, 51),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {
                                  if (_globalKey.currentState!.validate()) {
                                    if (EmailValidator.validate(
                                        _emailInput.text)) {
                                      _login();
                                    } else {
                                      showSnackbar(
                                          context,
                                          'Please enter a valid email',
                                          Colors.red);
                                    }
                                  } else {
                                    showSnackbar(context, 'Error in validation',
                                        Colors.red);
                                  }
                                },
                                child: const Text(
                                  "Sign in",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, RegisterScreen.route);
                            },
                            child: const Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 49, 49, 49),
                                  fontFamily: 'Raleway SemiBold',
                                  fontSize: 12),
                            ),
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
    );
  }
}

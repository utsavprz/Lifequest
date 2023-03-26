import 'package:flutter/material.dart';
import 'package:lifequest/app/snackbar.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/repository/user_repo.dart';
import 'package:lifequest/screens/wearos/wear_dashboard.dart';
import 'package:wear/wear.dart';

class WearLogin extends StatefulWidget {
  const WearLogin({super.key});

  static const String route = "WearLogin";
  @override
  State<WearLogin> createState() => _WearLoginState();
}

class _WearLoginState extends State<WearLogin> {
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();

  final _globalKey = GlobalKey<FormState>();

  _login() async {
    final islogin = await UserRepositoryImpl()
        .loginUser(context, _emailInput.text, _passwordInput.text);
    if (islogin) {
      // write here
      _goToAnotherPage();
      String? token = await SharedPref.getTokenFromPrefs();
      debugPrint(token);
    } else {
      _showMessage();
    }
  }

  _goToAnotherPage() {
    Navigator.pushReplacementNamed(context, WearDashboard.route);
  }

  _showMessage() {
    showSnackbar(context, 'Invalid username or password', Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (context, shape, child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Form(
                      key: _globalKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailInput,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email'),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: _passwordInput,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password'),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                _login();
                              },
                              child: const Text('Login')),
                        ],
                      )),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

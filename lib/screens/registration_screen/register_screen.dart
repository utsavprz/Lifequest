import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lifequest/app/snackbar.dart';
import 'package:lifequest/models/user.dart';
import 'package:lifequest/repository/user_repo.dart';
import 'package:lifequest/screens/login_screen.dart';
import 'package:password_strength/password_strength.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String route = 'UserRegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _gap = const SizedBox(
    height: 8,
  );

  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();
  final _confirmPasswordInput = TextEditingController();

  final _globalKey = GlobalKey<FormState>();

  final FocusNode _passwordFocus = FocusNode();

  _saveUser() async {
    _passwordFocus.unfocus();

    User user = User(
      email: _emailInput.text,
      password: _passwordInput.text,
    );

    int status = await UserRepositoryImpl().addUser(user);
    // print('REGISTRATIONSTATUS: $status');
    _showMessage(status);
  }

  _showMessage(int status) {
    switch (status) {
      case 409:
        showSnackbar(
            context, 'User with this email already exists', Colors.red);

        break;
      case 200:
        showSnackbar(context, 'User added successfully', Colors.green);
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            Navigator.pushReplacementNamed(context, LoginScreen.route);
          });
        });
        break;
      default:
        showSnackbar(context, 'Error in user registration', Colors.red);
    }
  }

  _validateAndSaveUser() {
    if (EmailValidator.validate(_emailInput.text)) {
      if (estimatePasswordStrength(_passwordInput.text) > 0.7) {
        if (_globalKey.currentState!.validate() &&
            _passwordInput.text == _confirmPasswordInput.text) {
          _saveUser();
        } else {
          showSnackbar(context, 'Error in validation', Colors.red);
        }
      } else {
        showSnackbar(
            context,
            'Enter a strong password with:\n \nAt least 8 characters\nAt least 1 uppercase letter\nAt least 1 number\nAt least 1 special character',
            Colors.red);
      }
    } else {
      showSnackbar(context, 'Enter a valid email', Colors.red);
    }
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
                height: height * 0.7,
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
                      'Create an account',
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
                        _gap,
                        TextFormField(
                          controller: _confirmPasswordInput,
                          focusNode: _passwordFocus,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
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
                                _validateAndSaveUser();
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.route,
                            );
                          },
                          child: const Text(
                            'Already have an account?',
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
      )),
    );
  }
}

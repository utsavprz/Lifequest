import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lifequest/app/snackbar.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/providers/user_provider.dart';
import 'package:lifequest/repository/user_repo.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lifequest/screens/home_main_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const String route = 'EditProfileScreen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      // Source is either Gallary or Camera
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final firstNameInput = TextEditingController(
      text: '${container.read(userProvider)!.profile!.firstName}');
  final lastNameInput = TextEditingController(
      text: '${container.read(userProvider)!.profile!.lastName}');
  final ageInput = TextEditingController();
  final phoneInput = TextEditingController();
  final cityInput = TextEditingController();
  final streetNameInput = TextEditingController();
  static const gap = SizedBox(
    height: 8,
  );

  final globalKey = GlobalKey<FormState>();
  final List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  _unfocusTextFields() {
    for (var focusNode in focusNodes) {
      focusNode.unfocus();
    }
  }

  updateUser() {
    if (globalKey.currentState!.validate()) {
      _unfocusTextFields();

      UserRepositoryImpl().updateUserProfile({
        'phone': phoneInput.text,
        'age': ageInput.text,
        'city': cityInput.text,
        'streetName': streetNameInput.text,
      }, _img).then((value) {
        print(value);
      });
      showSnackbar(context, 'User profile updated ', Colors.green);
      Navigator.pushNamed(context, HomeMainScreen.route);
    } else {
      showSnackbar(context, 'Fields cannot be empty', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 214, 1, 51),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: 20)),
            Expanded(
              child: Form(
                key: globalKey,
                child: SingleChildScrollView(
                  child: FocusScope(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        backgroundColor: Colors.grey[300],
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        builder: (context) => Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  _browseImage(
                                                      ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(Icons.camera),
                                                label: const Text('Camera'),
                                              ),
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  _browseImage(
                                                      ImageSource.gallery);
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(Icons.image),
                                                label: const Text('Gallery'),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100))),
                                          child: ClipOval(
                                            child: _img == null
                                                ? const Icon(
                                                    Icons.person,
                                                    size: 50,
                                                  )
                                                : Image.file(
                                                    _img!,
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 237, 237, 237),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.camera,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              gap,
                              gap,
                              gap,
                              Text(
                                'Edit your information',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              gap,
                              gap,
                              TextFormField(
                                focusNode: focusNodes[0],
                                controller: firstNameInput,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Fields cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                              gap,
                              TextFormField(
                                enabled: false,
                                controller: lastNameInput,
                                focusNode: focusNodes[1],
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
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Fields cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                              gap,
                              TextFormField(
                                controller: ageInput,
                                focusNode: focusNodes[2],
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
                                style: const TextStyle(fontSize: 14),
                                // validator: (val) {
                                //   if (val == null || val.isEmpty) {
                                //     return 'Fields cannot be empty';
                                //   } else {
                                //     if (int.parse(val) < 17) {
                                //       return 'Age must be greater than 17';
                                //     }
                                //     return null;
                                //   }
                                // },
                              ),
                              gap,
                              TextFormField(
                                controller: phoneInput,
                                focusNode: focusNodes[3],
                                style: const TextStyle(fontSize: 14),
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
                                // validator: (val) {
                                //   if (val == null || val.isEmpty) {
                                //     return 'Fields cannot be empty';
                                //   } else {
                                //     if (val.length < 10) {
                                //       return 'Invalid Phone number';
                                //     }
                                //     return null;
                                //   }
                                // },
                              ),
                              gap,
                              TextFormField(
                                controller: cityInput,
                                focusNode: focusNodes[4],
                                style: const TextStyle(fontSize: 14),
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
                                // validator: (val) {
                                //   if (val == null || val.isEmpty) {
                                //     return 'Fields cannot be empty';
                                //   }
                                //   return null;
                                // },
                              ),
                              gap,
                              TextFormField(
                                controller: streetNameInput,
                                focusNode: focusNodes[5],
                                style: const TextStyle(fontSize: 14),
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
                                // validator: (val) {
                                //   if (val == null || val.isEmpty) {
                                //     return 'Fields cannot be empty';
                                //   }
                                //   return null;
                                // },
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
                                          updateUser();
                                        },
                                        child: const Text(
                                          "Update",
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
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lifequest/app/constants.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/providers/user_provider.dart';
import 'package:lifequest/screens/bottom_screen/account_screens/profile_edit_screen.dart';
import 'package:lifequest/screens/login_screen.dart';
import 'package:lifequest/screens/previous_donation_record_screen.dart';
import 'package:lifequest/screens/previous_request_record_screen.dart';
import 'package:lifequest/utils/accounts_listtile.dart';

import '../../../main.dart';

class AccountScreen extends StatelessWidget {
  // const AccountScreen({super.key});
  static const String route = 'AccountScreen';

  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = container.read(userProvider);
    // print(user);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: SizedBox(
              width: double.infinity,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: ClipOval(
                          child: user?.profile?.image == null
                              ? const Icon(
                                  Icons.person,
                                  size: 50,
                                )
                              : Image.network(
                                  '${Constant.baseURL}images/user_image/${user?.profile!.image}',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Text(
                            user?.profile != null
                                ? '${user?.profile!.firstName} ${user?.profile!.lastName}'
                                : '${user?.email}',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 5),
                          user?.profile != null
                              ? Text(
                                  '${user?.profile!.streetName}, ${user?.profile!.city}',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                )
                              : const Text('')
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  ElevatedButton(
                    child: const Text('Edit Profile'),
                    onPressed: () {
                      Navigator.pushNamed(context, EditProfileScreen.route);
                    },
                  ),
                ],
              ),
            )),
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              // color: Colors.yellow,
              child: Column(
                children: [
                  AccountListTile(
                      tileLeading: 'Previous donation records',
                      tileRoute: 'Previous donation records',
                      tileIcon: const Icon(Icons.history),
                      tileFunction: () {
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(
                            context, PreviousDonationRecordScreen.route);
                      }),
                  AccountListTile(
                      tileLeading: 'Blood request records',
                      tileRoute: 'Blood request records',
                      tileIcon: const Icon(Icons.history),
                      tileFunction: () {
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(
                            context, PreviousRequestRecordScreen.route);
                      }),
                  // AccountListTile(
                  //   tileLeading: 'Redeem Points',
                  //   tileRoute: 'Redeem Points',
                  //   tileIcon: const Icon(Icons.redeem),
                  // ),
                  AccountListTile(
                    tileLeading: 'Need help?',
                    tileRoute: 'Need help?',
                    tileIcon: const Icon(Icons.help_outline_rounded),
                  ),
                  AccountListTile(
                      tileLeading: 'Logout',
                      tileRoute: 'Logout',
                      tileColor: Colors.red,
                      tileIcon: const Icon(
                        Icons.logout_rounded,
                        color: Colors.red,
                      ),
                      tileFunction: () async {
                        debugPrint('Logout');
                        await SharedPref.clearSharedPref();
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.route);
                      }),
                  // AccountListTile(
                  //     tileLeading: 'Token',
                  //     tileRoute: 'Token',
                  //     tileColor: Colors.grey,
                  //     tileIcon: const Icon(
                  //       Icons.key,
                  //       color: Colors.grey,
                  //     ),
                  //     tileFunction: () async {
                  //       String? token = await SharedPref.getTokenFromPrefs();

                  //       debugPrint(token);
                  //     }),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/utils/campaign_form.dart';
import 'package:lifequest/utils/campaign_list.dart';

import '../../../providers/user_provider.dart';

class DonateBloodScreen extends StatefulWidget {
  const DonateBloodScreen({super.key});

  static const String route = 'DonateBloodScreen';

  @override
  State<DonateBloodScreen> createState() => _DonateBloodScreenState();
}

class _DonateBloodScreenState extends State<DonateBloodScreen> {
  void _showFormDialog(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) => const CampaignForm(),
    );
    print('Result: $result');
  }

  @override
  Widget build(BuildContext context) {
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
                'Donate Blood',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 3,
                  children: [
                    const Text(
                      'Donation campaigns near',
                      style: TextStyle(fontFamily: 'Raleway Regular'),
                    ),
                    Text(
                      '${container.read(userProvider)!.profile!.streetName}, ${container.read(userProvider)!.profile!.city}',
                      style: const TextStyle(
                          color: Colors.green, fontFamily: 'Raleway SemiBold'),
                    )
                  ],
                ),
                // const Padding(
                //     padding: EdgeInsetsDirectional.symmetric(vertical: 2)),
                // const Text(
                //   'Showing results for all blood types',
                //   style: TextStyle(fontSize: 12, fontFamily: 'Raleway Regular'),
                // ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(20), child: const CampaignList()))
      ],
    )));
  }
}

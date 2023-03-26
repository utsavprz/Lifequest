import 'package:flutter/material.dart';
import 'package:lifequest/utils/hospitals_list.dart';

import '../../../main.dart';
import '../../../providers/user_provider.dart';

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({super.key});

  static const String route = 'HospitalScreen';

  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  final int _currentScreen = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   foregroundColor: ,
        //   title: Text(
        //     'Donate Blood',
        //     style: Theme.of(context).textTheme.headlineLarge,
        //   ),
        //   actions: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(Icons.add_circle),
        //     )
        //     // TextButton(onPressed: () {}, child: const Text('Start a campaign'))
        //   ],
        // ),
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
                'Hospitals',
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
                      'Hospitals near',
                      style: TextStyle(fontFamily: 'Raleway Regular'),
                    ),
                    Text(
                      '${container.read(userProvider)!.profile!.streetName}, ${container.read(userProvider)!.profile!.city}',
                      style: const TextStyle(
                          color: Colors.green, fontFamily: 'Raleway SemiBold'),
                    )
                  ],
                ),
                const Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 2)),
                const Text(
                  'Showing results for all types of hospitals and blood banks',
                  style: TextStyle(fontSize: 12, fontFamily: 'Raleway Regular'),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: const HospitalsList()))
      ],
    )));
  }
}

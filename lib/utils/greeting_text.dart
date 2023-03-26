import 'package:flutter/material.dart';
import 'package:lifequest/app/network_connectivity.dart';

class GreetingToUser extends StatefulWidget {
  final String name;

  const GreetingToUser({super.key, required this.name});

  @override
  State<GreetingToUser> createState() => _GreetingToUserState();
}

class _GreetingToUserState extends State<GreetingToUser> {
  bool? online;
  checkConnectivity() async {
    if (await NetworkConnectivity.isOnline()) {
      setState(() {
        online = true;
      });
    } else {
      online = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 10,
        children: [
          Text(
            'Hello! ${widget.name}, How are you?',
            style: const TextStyle(
                color: Colors.white, fontFamily: 'Raleway SemiBold'),
          ),
          Icon(
            online == true ? Icons.wifi : Icons.wifi_off,
            color: Colors.yellow,
            size: 20,
          )
        ],
      ),
    );
  }
}

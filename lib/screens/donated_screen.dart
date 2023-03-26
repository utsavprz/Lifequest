import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lifequest/models/user_blood_request.dart';
import 'package:lifequest/repository/blood_request_repo.dart';

class DonatedScreen extends StatefulWidget {
  const DonatedScreen({super.key});
  static const String route = 'DonatedScreen';

  @override
  State<DonatedScreen> createState() => _DonatedScreenState();
}

class _DonatedScreenState extends State<DonatedScreen> {
  UserBloodRequest? currentRequest;
  String requestId = '';

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments! as dynamic;
    requestId = jsonDecode(args['requestId'])['requestId'];
    await BloodRequestRepositoryImpl()
        .getBloodRequestById(requestId)
        .then((value) {
      setState(() {
        print(value);
        currentRequest = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        const Text('Thank you for donating and saving a life!'),
        Text(
            '${currentRequest!.user!.profile!.firstName} ${currentRequest!.user!.profile!.lastName} has marked the request as donated'),
      ],
    )));
  }
}

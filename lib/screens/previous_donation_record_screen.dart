import 'package:flutter/material.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/models/user_blood_request.dart';
import 'package:lifequest/providers/user_provider.dart';
import 'package:lifequest/repository/user_repo.dart';

class PreviousDonationRecordScreen extends StatefulWidget {
  const PreviousDonationRecordScreen({super.key});

  static const String route = 'PreviousDonationRecordScreen';

  @override
  State<PreviousDonationRecordScreen> createState() =>
      _PreviousDonationRecordScreenState();
}

class _PreviousDonationRecordScreenState
    extends State<PreviousDonationRecordScreen> {
  @override
  List<String> donationRequestsIds =
      container.read(userProvider)!.profile!.donationRecords!;
  @override
  void initState() {
    UserRepositoryImpl()
        .getUserById(container.read(userProvider)!.id!)
        .then((value) {
      print('userData:$value');
      setState(() {
        container.read(userProvider.notifier).setUser(value);
        donationRequestsIds = value.profile!.donationRecords!;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('donationRequestsIds:$donationRequestsIds');

    // print(donorsLst[0].profile);
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
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
            Text(
              '${container.read(userProvider)!.profile!.firstName}\'s donation record',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder(
                future:
                    UserRepositoryImpl().getDonationRecord(donationRequestsIds),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    List<UserBloodRequest> donationRequests =
                        List<UserBloodRequest>.from(snapshot.data as List);

                    return ListView.builder(
                      itemCount: donationRequests.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsetsDirectional.symmetric(
                              vertical: 5),
                          child: ListTile(
                            title: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'RequestDateTime: ',
                                      // 'asd',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      'DonatedDateTime: ',
                                      // 'asd',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Requested from: ',
                                      // 'asd',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      'Donated hospital: ',
                                      // 'asd',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      'Urgency: ',
                                      // 'asd',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      donationRequests[index]
                                          .datetimeRequested
                                          .toString(),
                                      // 'asd',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      donationRequests[index]
                                          .datetimeDonated
                                          .toString(),
                                      // 'asd',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          donationRequests[index]
                                              .user!
                                              .profile!
                                              .firstName
                                              .toString(),
                                          // 'asd',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                        Text(
                                          donationRequests[index]
                                              .user!
                                              .profile!
                                              .lastName
                                              .toString(),
                                          // 'asd',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      donationRequests[index]
                                          .hospital!
                                          .name
                                          .toString(),
                                      // 'asd',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      donationRequests[index]
                                          .urgency
                                          .toString(),
                                      // 'asd',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )))
    ])));
  }
}

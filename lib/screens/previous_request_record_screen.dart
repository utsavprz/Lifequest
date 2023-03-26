import 'package:flutter/material.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/models/user_blood_request.dart';
import 'package:lifequest/providers/user_provider.dart';
import 'package:lifequest/repository/user_repo.dart';

class PreviousRequestRecordScreen extends StatefulWidget {
  const PreviousRequestRecordScreen({super.key});

  static const String route = 'PreviousRequestRecordScreen';

  @override
  State<PreviousRequestRecordScreen> createState() =>
      _PreviousRequestRecordScreenState();
}

class _PreviousRequestRecordScreenState
    extends State<PreviousRequestRecordScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> requestsIds =
        container.read(userProvider)!.profile!.requestRecords!;

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
              '${container.read(userProvider)!.profile!.firstName}\'s blood request record',
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
                future: UserRepositoryImpl().getRequestRecord(requestsIds),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    List<UserBloodRequest> requestData =
                        List<UserBloodRequest>.from(snapshot.data as List);

                    return ListView.builder(
                      itemCount: requestData.length,
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
                                      'Donated from: ',
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
                                      requestData[index]
                                          .datetimeRequested
                                          .toString(),
                                      // 'asd',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      requestData[index]
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
                                          requestData[index]
                                              .donor!
                                              .profile!
                                              .firstName
                                              .toString(),
                                          // 'asd',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                        Text(
                                          requestData[index]
                                              .donor!
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
                                      requestData[index]
                                          .hospital!
                                          .name
                                          .toString(),
                                      // 'asd',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      requestData[index].urgency.toString(),
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

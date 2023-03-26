import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/models/user.dart';
import 'package:lifequest/providers/donors_provider.dart';
import 'package:lifequest/providers/user_provider.dart';

class DonorsScreen extends StatefulWidget {
  const DonorsScreen({super.key});

  static const String route = 'DonorsScreen';

  @override
  State<DonorsScreen> createState() => _DonorsScreenState();
}

class _DonorsScreenState extends State<DonorsScreen> {
  @override
  Widget build(BuildContext context) {
    List<User> donorsLst = container.read(donorsProvider);
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
            const Text(
              'Donors in my area',
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
                    'Blood donors near',
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
                'Showing results for all blood types',
                style: TextStyle(fontSize: 12, fontFamily: 'Raleway Regular'),
              ),
            ],
          ),
        ),
      ),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: donorsLst.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key: const ValueKey(0),

                    // The start action pane is the one at the left or the top side.
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(onDismissed: () {}),

                      // All actions are defined in the children parameter.
                      children: [
                        // A SlidableAction can have an icon and/or a label.
                        SlidableAction(
                          onPressed: (val) {},
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.call,
                          label: 'Call',
                        ),
                        SlidableAction(
                          onPressed: (val) {},
                          backgroundColor: const Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.message,
                          label: 'message',
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 2,
                      margin:
                          const EdgeInsetsDirectional.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Container(
                            width: 45,
                            height: 45,
                            decoration: const BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                            child: const Icon(Icons.person)),
                        trailing: const Text(
                          // donorsLst[index].profile!.bloodType.toString(),
                          'asd',
                          // 'asd',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway SemiBold'),
                        ),
                        title: Text(
                          donorsLst[index].email.toString(),
                          // 'asd',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                  );
                },
              )))
    ])));
  }
}

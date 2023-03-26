import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lifequest/main.dart';
import 'package:lifequest/providers/location_provider.dart';

class HospitalsList extends StatefulWidget {
  const HospitalsList({super.key});

  @override
  State<HospitalsList> createState() => _HospitalsListState();
}

class _HospitalsListState extends State<HospitalsList> {
  Future<List<dynamic>> getHospitalsNearby(
      double lat, double lon, int radius) async {
    final url =
        'https://nominatim.openstreetmap.org/search.php?q=hospital&format=json&lat=$lat&lon=$lon&radius=$radius';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body);
      final data = jsonDecode(response.body);
      print('Hospitals nearby:');
      print(data);
      return data;
    } else {
      throw Exception('Failed to get hospitals nearby');
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    print(container.read(locationProvider).latitude);
    print(container.read(locationProvider).longitude);
    super.initState();
  }

  getCurrentLocation() async {
    await container.read(locationProvider.notifier).getCurrentLocation();
  }

  dynamic hospitalLst = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getHospitalsNearby(container.read(locationProvider).latitude,
          container.read(locationProvider).longitude, 50),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          hospitalLst = snapshot.data;
          print(hospitalLst);
          return ListView.builder(
            itemCount: hospitalLst.length,
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
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (val) {},
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsetsDirectional.symmetric(vertical: 5),
                    child: ListTile(
                      title:
                          Text(hospitalLst[index]['display_name'].toString()),
                    ),
                  ));
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

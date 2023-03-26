import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

class OsmScreen extends StatefulWidget {
  const OsmScreen({super.key});
  static const String route = 'OsmScreen';

  @override
  State<OsmScreen> createState() => _OsmScreenState();
}

class _OsmScreenState extends State<OsmScreen> {
  Future searchPlace(String place) async {
    final searchResult = await Nominatim.searchByName(
      query: place,
      limit: 1,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    return searchResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FlutterMap(
          mapController: MapController(),
          options: MapOptions(
            center: LatLng(51.5, -0.09),
            zoom: 13.0,
          ),
          children: [
            Column(
              children: [
                TextFormField(
                  style: const TextStyle(fontSize: 12),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Select Hospital',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    searchPlace(value).then(
                      (value) {
                        setState(() {
                          SizedBox(
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: value!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: value[index]['name'],
                                );
                              },
                            ),
                          );
                        });
                        print('places: ${value['name']}');
                      },
                    );
                  },
                ),
                Expanded(
                  child: TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c']),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// class OsmScreen extends StatefulWidget {
//   const OsmScreen({super.key});
//   static const String route = 'OsmScreen';
//   @override
//   _OsmScreenState createState() => _OsmScreenState();
// }

// class _OsmScreenState extends State<OsmScreen> {
//   final _controller = TextEditingController();
//   List<Place> _places = [];

//   Future searchPlace(String place) async {
//     final places = await Nominatim.searchByName(
//       query: place,
//       limit: 2,
//       addressDetails: true,
//       extraTags: true,
//       nameDetails: true,
//     );
//     return places;
//   }
//   // Perform the search when the text changes

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             TextField(
//               controller: _controller,
//               onChanged: (value) {
//                 searchPlace(value).then((value) {
//                   setState(() {
//                     _places = value;
//                   });
//                 });
//               },
//             ),
//             _places.isNotEmpty
//                 ? Expanded(
//                     child: ListView.builder(
//                     itemCount: _places.length,
//                     itemBuilder: (context, index) {
//                       final place = _places[index];
//                       return ListTile(
//                         title: Text(place.nameDetails!['name']),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(place.displayName),
//                             // Text(
//                             //     '${place.address!['road']}, ${place.address!['neighbourhood']}, ${place.address!['suburb']}'),
//                             // Text(
//                             //     '${place.address!['municipality']}, ${place.address!['region']}, ${place.address!['country']}'),
//                           ],
//                         ),
//                       );
//                     },
//                   ))
//                 : Container()
//           ],
//         ),
//       ),
//     );
//   }
// }

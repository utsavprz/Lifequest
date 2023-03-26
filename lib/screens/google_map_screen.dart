import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  static const String route = 'GoogleMapScreen';

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  LatLng myLocation = const LatLng(27.7047139, 85.3295421);

  @override
  void initState() {
    markers.add(
      Marker(
          markerId: MarkerId(myLocation.toString()),
          position: myLocation,
          infoWindow: const InfoWindow(
              title: 'Gopal Dai ko Chatamari', snippet: 'Chatamari'),
          icon: BitmapDescriptor.defaultMarker),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: myLocation,
            zoom: 15,
          ),
          markers: markers,
          mapType: MapType.normal,
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          }),
    );
  }
}

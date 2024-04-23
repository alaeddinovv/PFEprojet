import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationTErrain extends StatelessWidget {
  final LatLng location;
  final String terrainId;
  const LocationTErrain(
      {super.key, required this.location, required this.terrainId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Location Terrain'),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: location,
            zoom: 19,
          ),
          markers: {
            Marker(
              markerId: MarkerId(terrainId),
              position: location,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
            )
          },
        ));
  }
}

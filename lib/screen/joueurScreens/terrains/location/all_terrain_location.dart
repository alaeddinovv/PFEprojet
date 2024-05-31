import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/details.dart';

class TestMap extends StatefulWidget {
  final List<TerrainModel> terrains;

  const TestMap({
    Key? key,
    required this.terrains,
  }) : super(key: key);

  @override
  State<TestMap> createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  GoogleMapController? _controller;
  LatLng? _temporaryPickedLocation;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    await _moveCameraToInitialLocation();
  }

  Future<void> _moveCameraToInitialLocation() async {
    if (_temporaryPickedLocation != null) {
      _controller!.moveCamera(
          CameraUpdate.newLatLngZoom(_temporaryPickedLocation!, 15));
    } else {
      await _moveToCurrentUserLocation();
    }
  }

  Future<void> _moveToCurrentUserLocation() async {
    final Location location = Location();

    // Check if location service is enabled and permissions are granted
    bool serviceEnabled = await location.serviceEnabled();
    PermissionStatus permissionGranted = await location.hasPermission();

    // If the service is not enabled, request it
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return; // If still not enabled, return
      }
    }

    // If permission is not granted, request it
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return; // If permission not granted, return
      }
    }

    // If all is good, fetch the current location and move the camera
    final locationData = await location.getLocation();
    _controller?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(locationData.latitude!, locationData.longitude!),
        15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _temporaryPickedLocation ??
                const LatLng(36.372773274225615, 6.590526919991559),
            zoom: 15,
          ),
          onTap: (location) {
            setState(() => _temporaryPickedLocation = location);
          },
          markers: _getMarkers(widget.terrains),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 8),
            FloatingActionButton(
              heroTag: 'myLocationBtn',
              onPressed: _moveToCurrentUserLocation,
              mini: true,
              child: const Icon(Icons.my_location),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ],
    );
  }

  Set<Marker> _getMarkers(List<TerrainModel> terrains) {
    final markers = <Marker>{};
    for (final terrain in terrains) {
      final marker = Marker(
        markerId: MarkerId(terrain.id!), // Use terrain ID for uniqueness
        position: LatLng(
            terrain.coordonnee!.latitude!, terrain.coordonnee!.longitude!),
        infoWindow: InfoWindow(
          onTap: () {
            navigatAndReturn(
                context: context,
                page: TerrainDetailsScreen(terrainModel: terrain));
          },
          title: terrain.adresse,
          snippet: terrain.description,
        ),
      );
      markers.add(marker);
    }
    return markers;
  }
}

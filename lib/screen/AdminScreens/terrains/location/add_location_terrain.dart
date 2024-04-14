import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPickerPage extends StatefulWidget {
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;

  const MapPickerPage({
    Key? key,
    required this.latitudeController,
    required this.longitudeController,
  }) : super(key: key);

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  GoogleMapController? _controller;
  LatLng? _temporaryPickedLocation;

  @override
  void initState() {
    super.initState();
    if (widget.latitudeController.text.isNotEmpty &&
        widget.longitudeController.text.isNotEmpty) {
      _temporaryPickedLocation = LatLng(
          double.tryParse(widget.latitudeController.text)!,
          double.tryParse(widget.longitudeController.text)!);
    }
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

  void _deleteMarker() {
    setState(() {
      _temporaryPickedLocation = null; // Clear the selected location
    });
    // Optionally reset the text fields
    widget.latitudeController.clear();
    widget.longitudeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Location')),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _temporaryPickedLocation ?? const LatLng(0, 0),
              zoom: 15,
            ),
            onTap: (location) {
              setState(() => _temporaryPickedLocation = location);
            },
            markers: _temporaryPickedLocation != null
                ? {
                    Marker(
                        markerId: const MarkerId('pickedLocation'),
                        position: _temporaryPickedLocation!)
                  }
                : {},
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'deleteMarkerBtn',
                onPressed: _deleteMarker,
                mini: true,
                child: const Icon(Icons.delete),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                heroTag: 'myLocationBtn',
                onPressed: _moveToCurrentUserLocation,
                mini: true,
                child: const Icon(Icons.my_location),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                heroTag: 'confirmBtn',
                onPressed: () {
                  // Only update the text fields and return the picked location if it's not null
                  if (_temporaryPickedLocation != null) {
                    widget.latitudeController.text =
                        _temporaryPickedLocation!.latitude.toString();
                    widget.longitudeController.text =
                        _temporaryPickedLocation!.longitude.toString();
                    Navigator.of(context).pop(); // Return the picked location
                  } else {
                    // If no location was picked, just pop back without updating the controllers or passing data
                    Navigator.of(context).pop();
                  }
                },
                child: const Icon(Icons.check),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

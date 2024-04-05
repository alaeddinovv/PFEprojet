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
  final Location _location = Location();

  @override
  void initState() {
    super.initState();
    if (widget.latitudeController.text.isNotEmpty &&
        widget.longitudeController.text.isNotEmpty) {
      _temporaryPickedLocation = LatLng(
        double.tryParse(widget.latitudeController.text) ?? 0,
        double.tryParse(widget.longitudeController.text) ?? 0,
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _moveCameraToInitialLocation();
  }

  Future<void> _moveCameraToInitialLocation() async {
    if (_temporaryPickedLocation != null) {
      _controller!.moveCamera(
          CameraUpdate.newLatLngZoom(_temporaryPickedLocation!, 15));
    } else {
      _moveToCurrentUserLocation();
    }
  }

  Future<void> _moveToCurrentUserLocation() async {
    final locationData = await _location.getLocation();
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
      body: GoogleMap(
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
      floatingActionButton: Column(
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
    );
  }
}

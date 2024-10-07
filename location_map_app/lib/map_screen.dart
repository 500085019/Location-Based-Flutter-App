import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location_service.dart'; // Ensure you have a service to fetch coordinates

class MapScreen extends StatefulWidget {
  final String location;

  const MapScreen({super.key, required this.location});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _locationCoordinates;
  final Set<Marker> _markers = {};
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _getLocationCoordinates();
  }

  Future<void> _getLocationCoordinates() async {
    String location = widget.location;

    if (location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location is empty')),
      );
      return;
    }

    try {
      LatLng coordinates = (await LocationService.getCoordinatesFromAddress(location)) as LatLng;
      setState(() {
        _locationCoordinates = coordinates;
        _markers.add(
          Marker(
            markerId: const MarkerId('user_location'),
            position: coordinates,
            infoWindow: InfoWindow(title: location),
          ),
        );
      });

      // Move the camera to the new location
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(coordinates),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to find location')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
      ),
      body: _locationCoordinates == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _locationCoordinates!,
                zoom: 14.0,
              ),
              markers: _markers,
            ),
    );
  }
}

// Filename: map_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Use flutter_map for OpenStreetMap
import 'package:latlong2/latlong.dart'; // Use latlong2 for coordinates

class MapScreen extends StatelessWidget {
  final String location;
  final double latitude;
  final double longitude;

  const MapScreen({
    Key? key, // Using Key? for the key parameter
    required this.location,
    required this.latitude,
    required this.longitude,
  }) : super(key: key); // Initialize the superclass

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map View for $location"),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(latitude, longitude), // Center the map on the given coordinates
          zoom: 13.0, // Default zoom level
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", // OpenStreetMap tile URL
            subdomains: ['a', 'b', 'c'], // Subdomains for tile loading
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                point: LatLng(latitude, longitude), // Marker position
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  size: 40.0,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

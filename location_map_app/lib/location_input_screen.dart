import 'package:flutter/material.dart';
import 'map_screen.dart'; // Import the MapScreen class

class LocationInputScreen extends StatefulWidget {
  @override
  _LocationInputScreenState createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  final TextEditingController _controller = TextEditingController();
  String _location = '';

  void _navigateToMap() {
    if (_controller.text.isNotEmpty) {
      _location = _controller.text;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(location: _location),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a location')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Location')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Location (City, Address, or Coordinates)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToMap,
              child: Text('Show on Map'),
            ),
          ],
        ),
      ),
    );
  }
}

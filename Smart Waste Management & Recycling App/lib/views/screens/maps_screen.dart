import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  // Dummy location: San Francisco
  static const LatLng _center = const LatLng(37.7749, -122.4194);
  GoogleMapController? mapController;

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('center_1'),
      position: LatLng(37.7749, -122.4194),
      infoWindow: InfoWindow(title: 'City Recycling Hub', snippet: 'Accepts Plastics & Electronics'),
    ),
    Marker(
      markerId: MarkerId('center_2'),
      position: LatLng(37.7849, -122.4094),
      infoWindow: InfoWindow(title: 'Green Earth E-Waste', snippet: 'E-Waste specific processing'),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Recycling Centers"),
        backgroundColor: Colors.green.shade700,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 13.0,
        ),
        markers: _markers,
        myLocationEnabled: true,
      ),
    );
  }
}

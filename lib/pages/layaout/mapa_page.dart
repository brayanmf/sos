import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapaPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapaPage({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    // Definimos el punto de la ubicación
    final LatLng userLocation = LatLng(latitude, longitude);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Ubicación'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: FlutterMap(
        options: MapOptions(initialCenter: userLocation, initialZoom: 15.0),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.tgestiona.evac',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: userLocation,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

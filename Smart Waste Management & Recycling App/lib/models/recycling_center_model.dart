import 'package:google_maps_flutter/google_maps_flutter.dart';

class RecyclingCenter {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final List<String> acceptedTypes;

  RecyclingCenter({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.acceptedTypes = const [],
  });

  LatLng get latLng => LatLng(latitude, longitude);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'acceptedTypes': acceptedTypes,
      };

  factory RecyclingCenter.fromMap(Map<String, dynamic> map) {
    return RecyclingCenter(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      address: map['address'] as String? ?? '',
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0,
      acceptedTypes: List<String>.from(map['acceptedTypes'] as List? ?? []),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class DisasterModel {
  final String id;
  final String userId;
  final String disasterType;
  final String disasterProvince;
  final String disasterDescription;
  List<String>? disasterImageUrls;
  final PlaceLocation disasterLocation;
  final DateTime createdAt;

  DisasterModel({
    required this.id,
    required this.userId,
    required this.disasterType,
    required this.disasterProvince,
    required this.disasterDescription,
    required this.disasterImageUrls,
    required this.disasterLocation,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  static DisasterModel empty() => DisasterModel(
        id: '',
        disasterType: '',
        disasterProvince: '',
        disasterDescription: '',
        disasterImageUrls: [],
        disasterLocation: PlaceLocation(latitude: 0, longitude: 0, address: ''),
        userId: '',
        createdAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'disasterType': disasterType,
      'disasterProvince': disasterProvince,
      'disasterDescription': disasterDescription,
      'disasterImageUrls': disasterImageUrls,
      'createdAt': createdAt,
      'disasterLocation': disasterLocation.toJson(),
    };
  }

  factory DisasterModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return DisasterModel.empty();
    final data = document.data()!;
    return DisasterModel(
      id: document.id,
      disasterLocation: PlaceLocation.fromJson(data['disasterLocation']),
      userId: data['userId'] ?? '',
      disasterType: data['disasterType'] ?? '',
      disasterProvince: data['disasterProvince'] ?? '',
      disasterDescription: data['disasterDescription'] ?? '',
      disasterImageUrls: List<String>.from(data['disasterImageUrls'] ?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  factory PlaceLocation.fromJson(Map<String, dynamic> json) {
    return PlaceLocation(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      address: json['address'] ?? '',
    );
  }
}

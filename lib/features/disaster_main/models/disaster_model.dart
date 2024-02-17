import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_zone/features/personalization/models/user_model.dart';

class DisasterModel {
  final String id;
  UserModel? userModel;
  final String userId;
  final String disasterType;
  final String disasterProvince;
  final String disasterDescription;
  final List<String> disasterImages;
  List<Map<String, String>> disasterImageUrls;
  final PlaceLocation disasterLocation;
  final DateTime createdAt = DateTime.now();

  DisasterModel({
    required this.id,
    required this.userId,
    required this.disasterType,
    required this.disasterProvince,
    required this.disasterDescription,
    required this.disasterImages,
    required this.disasterImageUrls,
    required this.disasterLocation,
  });

  static DisasterModel empty() => DisasterModel(
        id: '',
        disasterType: '',
        disasterProvince: '',
        disasterDescription: '',
        disasterImages: [],
        disasterImageUrls: [],
        disasterLocation: PlaceLocation(latitude: 0, longitude: 0, address: ''),
        userId: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'disasterType': disasterType,
      'disasterProvince': disasterProvince,
      'disasterDescription': disasterDescription,
      'disasterImages': disasterImages,
      'disasterImageUrls': disasterImageUrls,
      'createdAt': createdAt,
      'disasterLocation': disasterLocation.toJson(),
    };
  }

  factory DisasterModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return DisasterModel(
        id: document.id,
        disasterLocation: PlaceLocation.fromJson(data['disasterLocation']),
        userId: data['userId'] ?? '',
        disasterType: data['disasterType'] ?? '',
        disasterProvince: data['disasterProvince'] ?? '',
        disasterDescription: data['disasterDescription'],
        disasterImages: List<String>.from(data['disasterImages'] ?? []),
        disasterImageUrls: List<Map<String, String>>.from(data['disasterImageUrls'] ?? []),
      );
    }
    return DisasterModel.empty();
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

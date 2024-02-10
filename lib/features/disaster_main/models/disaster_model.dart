import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_zone/features/personalization/models/user_model.dart';

class DisasterModel {
  final String id;
  UserModel? userModel;
  final String userId;
  final String disasterType;
  final String disasterProvince;
  final String disasterDescription;
  String disasterImage;
  final String disasterLocation;
  final DateTime createdAt = DateTime.now();

  DisasterModel({
    required this.id,
    required this.userId,
    required this.disasterType,
    required this.disasterProvince,
    required this.disasterDescription,
    required this.disasterImage,
    required this.disasterLocation,
  });

  static DisasterModel empty() => DisasterModel(id: '', disasterType: '', disasterProvince: '', disasterDescription: '', disasterImage: '', disasterLocation: '', userId: '');

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'disasterType': disasterType,
      'disasterProvince': disasterProvince,
      'disasterDescription': disasterDescription,
      'disasterImage': disasterImage,
      'disasterLocation': disasterLocation,
      'createdAt': createdAt,
    };
  }

  factory DisasterModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return DisasterModel(
        id: document.id,
        disasterLocation: data['disasterLocation'] ?? '',
        userId: data['userId'] ?? '',
        disasterType: data['disasterType'] ?? '',
        disasterProvince: data['disasterProvince'] ?? '',
        disasterDescription: data['disasterDescription'],
        disasterImage: data['disasterImage'] ?? '',
      );
    }
    return DisasterModel.empty();
  }
}

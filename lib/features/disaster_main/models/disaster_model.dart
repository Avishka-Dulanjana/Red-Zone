import 'package:cloud_firestore/cloud_firestore.dart';

class DisasterModel {
  final String id;
  final String disasterType;
  final String disasterProvince;
  final String disasterDescription;
  final String disasterImage;
  final String disasterLocation;
  //final DateTime? createdAt;
  //final DateTime? updatedAt;

  DisasterModel({
    required this.id,
    required this.disasterType,
    required this.disasterProvince,
    required this.disasterDescription,
    required this.disasterImage,
    required this.disasterLocation,
    //this.createdAt,
    //this.updatedAt,
  });

  static DisasterModel empty() => DisasterModel(id: '', disasterType: '', disasterProvince: '', disasterDescription: '', disasterImage: '', disasterLocation: '');

  Map<String, dynamic> toJson() {
    return {
      'disasterType': disasterType,
      'disasterProvince': disasterProvince,
      'disasterDescription': disasterDescription,
      'disasterImage': disasterImage,
      'disasterLocation': disasterLocation,
      //'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      //'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  factory DisasterModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return DisasterModel(
        id: document.id,
        disasterType: data['disasterType'] ?? '',
        disasterProvince: data['disasterProvince'] ?? '',
        disasterDescription: data['disasterDescription'] ?? '',
        disasterImage: data['disasterImage'] ?? '',
        disasterLocation: data['disasterLocation'] ?? '',
        //data['createdAt'],
        //data['updatedAt'],
      );
    }
    return DisasterModel.empty();
  }
}

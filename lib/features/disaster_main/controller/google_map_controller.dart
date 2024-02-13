// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart';
//
// import '../models/disaster_model.dart';
// import '../screens/new_disaster/widgets/google_map_screen.dart';
//
// class GoogleMappingController extends GetxController {
//   static GoogleMappingController get instance => Get.find();
//
//   final Rx<LatLng?> customMarkerLocation = Rx<LatLng?>(null);
//   final RxString selectedMapAddress = RxString('');
//   final RxString googleMapLocation = RxString('');
//   final Rx<PlaceLocation?> newGoogleMapLocation = Rx<PlaceLocation?>(null);
//   final googleLocationImage = RxString('');
//
//   // Add Disaster Form Key
//   GlobalKey<FormState> googleMapFormKey = GlobalKey<FormState>();
//
//   // Get Custom Marker Location from Google Map
//   void saveCustomMarkerLocation(LatLng? markerLocation) {
//     customMarkerLocation.value = markerLocation;
//   }
//
//   // Open Google Map Screen
//   void openGoogleMapScreen({
//     required void Function(LatLng?) onLocationPicked,
//     required void Function() onSaveCustomMarkerCallback,
//   }) {
//     Get.to(() => GoogleMapScreen(
//           location: PlaceLocation(latitude: 37.422, longitude: -122.084, address: ''),
//           isSelecting: true,
//           onSaveCustomMarkerCallback: onSaveCustomMarker,
//           onLocationPicked: (PlaceLocation? pickedLocation) {
//             if (pickedLocation != null) {
//               customMarkerLocation.value = LatLng(pickedLocation.latitude, pickedLocation.longitude);
//             }
//             onLocationPicked(customMarkerLocation.value);
//           },
//         ));
//   }
//
//   // Save custom marker location
//   void onSaveCustomMarker() async {
//     if (customMarkerLocation.value != null) {
//       // Update googleMapLocation with the latitude and longitude values
//       googleMapLocation.value = '${customMarkerLocation.value!.latitude},${customMarkerLocation.value!.longitude}';
//
//       newGoogleMapLocation.value = PlaceLocation(
//         latitude: customMarkerLocation.value!.latitude,
//         longitude: customMarkerLocation.value!.longitude,
//         address: selectedMapAddress.value,
//       );
//
//       final lat = newGoogleMapLocation.value?.latitude;
//       final lng = newGoogleMapLocation.value?.longitude;
//
//       if (lat == null || lng == null) {
//         return;
//       }
//
//       print(newGoogleMapLocation.value?.longitude);
//       print(newGoogleMapLocation.value?.latitude);
//
//       final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyBt4iFeic3dBUU-GJNBWNJLqQ3xNOiuZfI');
//
//       final response = await http.get(url);
//       final resData = json.decode(response.body);
//       final address = resData['results'][0]['formatted_address'];
//
//       newGoogleMapLocation.value = PlaceLocation(latitude: lat, longitude: lng, address: address);
//       googleLocationImage.value =
//           'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyBt4iFeic3dBUU-GJNBWNJLqQ3xNOiuZfI';
//     }
//   }
//
//   // Update the selected location
//   void updateSelectedLocation(LatLng? pickedLocation) {
//     if (pickedLocation != null) {
//       // Assuming pickedLocation is an instance of LatLng
//       PlaceLocation(
//         latitude: pickedLocation.latitude,
//         longitude: pickedLocation.longitude,
//         address: selectedMapAddress.value,
//       );
//     }
//
//     final lat = pickedLocation?.latitude;
//     final lng = pickedLocation?.longitude;
//
//     if (lat == null || lng == null) {
//       return;
//     }
//   }
// }

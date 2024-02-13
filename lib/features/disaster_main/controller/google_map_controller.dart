import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapController extends GetxController {
  final Rx<LatLng?> customMarkerLocation = Rx<LatLng?>(null);
  final RxString selectedMapAddress = RxString('');
  final RxString googleMapLocation = RxString('');
  //final customMarkerLocation = Rx<LatLng?>(null);

  // Add Disaster Form Key
  GlobalKey<FormState> googleMapFormKey = GlobalKey<FormState>();

  // Get Custom Marker Location from Google Map
  void saveCustomMarkerLocation(LatLng? markerLocation) {
    customMarkerLocation.value = markerLocation;
  }

  // Save custom marker location
  void onSaveCustomMarker() {
    if (customMarkerLocation.value != null) {
      // Update googleMapLocation with the latitude and longitude values
      googleMapLocation.value = '${customMarkerLocation.value!.latitude},${customMarkerLocation.value!.longitude}';
    }
  }

  // // Get Custom Marker Location from Google Map
  // void saveCustomMarkerLocation(LatLng? markerLocation) {
  //   customMarkerLocation.value = markerLocation;
  // }
  //
  // // Open Google Map Screen
  // void openGoogleMapScreen() {
  //   Get.to(() => GoogleMapScreen(
  //     location: PlaceLocation(latitude: 37.422, longitude: -122.084, address: ''),
  //     isSelecting: true,
  //     onSaveCustomMarkerCallback: onSaveCustomMarker, // Provide the callback
  //   ));
  // }
  //
  // // Save custom marker location
  // void onSaveCustomMarker() {
  //   if (customMarkerLocation.value != null) {
  //     // Update googleMapLocation with the latitude and longitude values
  //     googleMapLocation.value = '${customMarkerLocation.value!.latitude},${customMarkerLocation.value!.longitude}';
  //
  //     pickedLocation.value = PlaceLocation(
  //       latitude: customMarkerLocation.value!.latitude,
  //       longitude: customMarkerLocation.value!.longitude,
  //       address: selectedMapAddress.value,
  //     );
  //   }
  // }
}

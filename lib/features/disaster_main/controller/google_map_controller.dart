import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/disaster_model.dart';
import '../screens/new_disaster/widgets/google_map_screen.dart';

class GoogleMappingController extends GetxController {
  static GoogleMappingController get instance => Get.find();

  final Rx<LatLng?> customMarkerLocation = Rx<LatLng?>(null);
  final RxString selectedMapAddress = RxString('');
  final RxString googleMapLocation = RxString('');
  final Rx<PlaceLocation?> pickedLocation = Rx<PlaceLocation?>(null);

  // Add Disaster Form Key
  GlobalKey<FormState> googleMapFormKey = GlobalKey<FormState>();

  // Get Custom Marker Location from Google Map
  void saveCustomMarkerLocation(LatLng? markerLocation) {
    customMarkerLocation.value = markerLocation;
  }

  // Open Google Map Screen
  void openGoogleMapScreen({
    required void Function(LatLng?) onLocationPicked,
    required void Function() onSaveCustomMarkerCallback,
  }) {
    Get.to(() => GoogleMapScreen(
          location: PlaceLocation(latitude: 37.422, longitude: -122.084, address: ''),
          isSelecting: true,
          onSaveCustomMarkerCallback: onSaveCustomMarker,
          onLocationPicked: (PlaceLocation? pickedLocation) {
            if (pickedLocation != null) {
              customMarkerLocation.value = LatLng(pickedLocation.latitude, pickedLocation.longitude);
            }
            onLocationPicked(customMarkerLocation.value);
          },
        ));
  }

  // Save custom marker location
  void onSaveCustomMarker() {
    if (customMarkerLocation.value != null) {
      // Update googleMapLocation with the latitude and longitude values
      googleMapLocation.value = '${customMarkerLocation.value!.latitude},${customMarkerLocation.value!.longitude}';

      pickedLocation.value = PlaceLocation(
        latitude: customMarkerLocation.value!.latitude,
        longitude: customMarkerLocation.value!.longitude,
        address: selectedMapAddress.value,
      );
    }
  }

  // Update the selected location
  void updateSelectedLocation(LatLng? pickedLocation) {
    if (pickedLocation != null) {
      // Assuming pickedLocation is an instance of LatLng
      PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: selectedMapAddress.value,
      );
    }
  }
}

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:red_zone/utils/constants/loaders.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../../../data/repositories/disaster/disaster_repository.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../models/disaster_model.dart';
import '../screens/new_disaster/widgets/google_map_screen.dart'; // Import your GoogleMapScreen class

class DisasterController extends GetxController {
  static DisasterController get instance => Get.find();

  final disasterLoading = false.obs;
  Rx<DisasterModel> disaster = DisasterModel.empty().obs;

  // Form Fields
  final disasterType = RxString('');
  final disasterProvince = RxString('');
  final disasterDistrict = RxString('');
  final disasterDescription = TextEditingController();
  final disasterRepository = Get.put(DisasterRepository());
  final locationImage = RxString('');
  final pickedLocation = Rx<PlaceLocation?>(null);

  // List to hold selected image paths
  final RxList<String> disasterImages = RxList<String>();

  // Add Disaster Form Key
  GlobalKey<FormState> addDisasterFormKey = GlobalKey<FormState>();

  // Save Disaster Record to Firestore
  Future<void> saveDisasterRecord() async {
    // Start Loading
    TFullScreenLoader.openLoadingDialog(text: 'We are processing your information', animation: TImages.docerAnimation);

    // Check Internet Connection
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }

    // Form Validation
    if (!addDisasterFormKey.currentState!.validate()) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      return;
    }

    final userCredential = FirebaseAuth.instance.currentUser;
    try {
      final newDisaster = DisasterModel(
        id: '${userCredential?.uid}-${DateTime.now().millisecondsSinceEpoch}',
        userId: userCredential!.uid,
        disasterType: disasterType.value,
        disasterProvince: disasterProvince.value,
        disasterDistrict: disasterDistrict.value,
        disasterDescription: disasterDescription.text.trim(),
        disasterImageUrls: [],
        disasterLocation: pickedLocation.value ?? newGoogleMapLocation.value ?? PlaceLocation(latitude: 0, longitude: 0, address: ''),
      );

      print(newDisaster.toJson());

      // Upload images and get URLs

      // final List<Map<String, String>> imageUrls = [];
      final List<String> imageUrls = [];
      for (final imagePath in disasterImages) {
        final imageUrl = await disasterRepository.uploadDisasterImage('disaster_images', XFile(imagePath));
        imageUrls.add(imageUrl);
      }

      print('Image URLs: $imageUrls'); // Add this line for debugging

      newDisaster.disasterImageUrls = imageUrls;

      // Save the disaster record with the image URLs
      await disasterRepository.saveDisasterRecord(newDisaster);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(title: 'Successfully Added!!!', message: 'Your disaster report has been submitted successfully!');

      // Clear the form fields
      disasterType.value = '';
      disasterProvince.value = '';
      disasterDistrict.value = '';
      disasterDescription.clear();
      disasterImages.clear();
      pickedLocation.value = null;

      // Move to Previous Screen
      Get.off(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Data not saved', message: e.toString());
    }
  }

  // Pick multiple images
  Future<void> pickImages() async {
    try {
      final int currentImagesCount = disasterImages.length;
      final int remainingImagesCount = 5 - currentImagesCount;
      if (remainingImagesCount <= 0) return;

      final List<XFile> images = await ImagePicker().pickMultiImage(
        imageQuality: 50, // Adjust quality as needed
        maxWidth: 800, // Adjust max width as needed
      );

      if (images.isNotEmpty) {
        if (images.length > remainingImagesCount) {
          disasterImages.addAll(images.sublist(0, remainingImagesCount).map((image) => image.path));
        } else {
          disasterImages.addAll(images.map((image) => image.path));
        }
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  // Get Current Location
  Future<void> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    print(locationData.longitude);
    print(locationData.latitude);

    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyBt4iFeic3dBUU-GJNBWNJLqQ3xNOiuZfI');

    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];

    pickedLocation.value = PlaceLocation(latitude: lat, longitude: lng, address: address);
    locationImage.value =
        'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyBt4iFeic3dBUU-GJNBWNJLqQ3xNOiuZfI';
  }

  /// ToDo: Method to select an Google Map

  final Rx<LatLng?> customMarkerLocation = Rx<LatLng?>(null);
  final RxString selectedMapAddress = RxString('');
  final RxString googleMapLocation = RxString('');
  final Rx<PlaceLocation?> newGoogleMapLocation = Rx<PlaceLocation?>(null);
  final googleLocationImage = RxString('');

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
  void onSaveCustomMarker() async {
    if (customMarkerLocation.value != null) {
      // Update googleMapLocation with the latitude and longitude values
      googleMapLocation.value = '${customMarkerLocation.value!.latitude},${customMarkerLocation.value!.longitude}';

      newGoogleMapLocation.value = PlaceLocation(
        latitude: customMarkerLocation.value!.latitude,
        longitude: customMarkerLocation.value!.longitude,
        address: selectedMapAddress.value,
      );

      final lat = newGoogleMapLocation.value?.latitude;
      final lng = newGoogleMapLocation.value?.longitude;

      if (lat == null || lng == null) {
        return;
      }

      print(newGoogleMapLocation.value?.longitude);
      print(newGoogleMapLocation.value?.latitude);

      final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyBt4iFeic3dBUU-GJNBWNJLqQ3xNOiuZfI');

      final response = await http.get(url);
      final resData = json.decode(response.body);
      final address = resData['results'][0]['formatted_address'];

      newGoogleMapLocation.value = PlaceLocation(latitude: lat, longitude: lng, address: address);
      googleLocationImage.value =
          'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyBt4iFeic3dBUU-GJNBWNJLqQ3xNOiuZfI';
    }
  }

  //Update the selected location
  void updateSelectedLocation(LatLng? pickedLocation) {
    if (pickedLocation != null) {
      // Assuming pickedLocation is an instance of LatLng
      PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: selectedMapAddress.value,
      );
    }

    final lat = pickedLocation?.latitude;
    final lng = pickedLocation?.longitude;

    if (lat == null || lng == null) {
      return;
    }
  }
}

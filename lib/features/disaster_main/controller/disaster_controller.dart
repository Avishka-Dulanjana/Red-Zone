import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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

class DisasterController extends GetxController {
  static DisasterController get instance => Get.find();

  final disasterLoading = false.obs;
  Rx<DisasterModel> disaster = DisasterModel.empty().obs;

  final disasterType = RxString('');
  final disasterProvince = RxString('');
  final disasterDescription = TextEditingController();
  final disasterLocation = TextEditingController();
  final disasterRepository = Get.put(DisasterRepository());
  final disasterImage = RxString('');
  final pickedLocation = Rx<PlaceLocation?>(null);
  final locationImage = RxString('');
  GlobalKey<FormState> addDisasterFormKey = GlobalKey<FormState>();

  final picker = ImagePicker();

  // Method to select an image
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Update disasterImage with the path of the selected image
      disasterImage.value = pickedFile.path;
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
        disasterDescription: disasterDescription.text.trim(),
        disasterImage: disasterImage.value,
        disasterLocation: pickedLocation.value ?? PlaceLocation(latitude: 0, longitude: 0, address: ''),
      );

      print(newDisaster.toJson());

      // Upload image and get URL
      final imageUrl = await disasterRepository.uploadDisasterImage('disaster_images', XFile(disasterImage.value));

      print('Image URL: $imageUrl'); // Add this line for debugging

      // Update the newDisaster with the image URL
      newDisaster.disasterImage = imageUrl;

      // Save the disaster record with the image URL
      await disasterRepository.saveDisasterRecord(newDisaster);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(title: 'Successfully Added!!!', message: 'Your disaster report has been submitted successfully!');

      // Move to Previous Screen
      Get.off(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Data not saved', message: e.toString());
    }
  }
}

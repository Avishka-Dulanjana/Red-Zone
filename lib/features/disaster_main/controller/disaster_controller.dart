import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:red_zone/utils/constants/loaders.dart';

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

    final userCredential = FirebaseAuth.instance.currentUser;
    try {
      final newDisaster = DisasterModel(
        id: userCredential!.uid,
        disasterType: disasterType.value ?? '',
        disasterProvince: disasterProvince.value ?? '',
        disasterDescription: disasterDescription.text ?? '',
        disasterImage: '',
        disasterLocation: '',
      );

      print(newDisaster.toJson());

      //final disasterRepository = Get.put(DisasterRepository());
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

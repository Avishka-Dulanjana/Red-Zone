import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_zone/utils/constants/loaders.dart';
import 'package:red_zone/utils/helpers/network_manager.dart';
import 'package:red_zone/utils/popups/full_screen_loader.dart';

import '../../../../utils/constants/image_strings.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables

  final hidePassword = true.obs; // Observable for hiding/showing password
  final privacyPolicy = true.obs; // Observable for privacy policy checkbox
  final email = TextEditingController(); // Controller for email input
  final firstName = TextEditingController(); // Controller for first name input
  final lastName = TextEditingController(); // Controller for last name input
  final username = TextEditingController(); // Controller for username input
  final password = TextEditingController(); // Controller for password input
  final phoneNumber = TextEditingController(); // Controller for phone number input
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // Form key for form validation

// -- Signup

  Future<void> signup() async {
    try {
      // TODO: Start Loading
      TFullScreenLoader.openLoadingDialog(text: 'We are processing your information...', animation: TImages.docerAnimation);

      // TODO: Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // TODO: Form Validation
      if (signupFormKey.currentState!.validate()) return;

      // TODO: Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Acceptance Required',
          message: 'In order to proceed, you must read and accept our Privacy Policy and Terms & Conditions.',
        );
        return;
      }

      // TODO: Register user in the Firebase Authentication & save user data in Firebase

      // TODO: Save Authenticated user data in the Firebase Firestore

      // TODO: Show Success Message

      // TODO: Move to Verify Email Screen
    } catch (e) {
      // TODO: Show some generic errors to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // TODO: Remove Loader
      TFullScreenLoader.stopLoading();
    }
  }
}

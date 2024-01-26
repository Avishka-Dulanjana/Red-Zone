import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:red_zone/features/authentication/screens/login/login.dart';
import 'package:red_zone/features/authentication/screens/onboarding/onboarding.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();

  // Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // Function to show relevant screen
  screenRedirect() async {
    // Local Storage
    if (kDebugMode) {
      print('======== GET STORAGE ========');
      print(deviceStorage.read('isFirstTime'));
    }

    deviceStorage.writeIfNull('isFirstTime', true);
    deviceStorage.read('isFirstTime') != true ? Get.offAll(() => const LoginScreen()) : Get.offAll(() => const OnBoardingScreen());
  }

  /* ------------------------Email & Password sign in ------------------------ */

  // [EmailAuthentication] - SignIn

  // [EmailAuthentication] - REGISTER

  // [ReAuthentication] - ReAuthentication User

  // [EmailVerification] - MAIL VERIFICATION

  // [EmailAuthentication] - FORGOT PASSWORD

  /* -------------------- Federated identity & social sign-in -------------------- */

  // [GoogleAuthentication] - GOOGLE SIGN IN

  // [FacebookAuthentication] - FACEBOOK SIGN IN

  /* ------------------------ ./end federated identity & social sign-in ------------------------ */

  // [LogoutUser] - Valid for any authenticated user

  // DELETE USER - Remove user Auth and Firestore Account
}

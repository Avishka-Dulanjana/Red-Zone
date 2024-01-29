import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:red_zone/features/authentication/screens/login/login.dart';
import 'package:red_zone/features/authentication/screens/onboarding/onboarding.dart';
import 'package:red_zone/navigation_menu.dart';

import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Called from main.dart on app launch
  @override
  void onReady() {
    // Remove splash screen
    FlutterNativeSplash.remove();
    // Redirect to the relevant screen
    screenRedirect();
  }

  // Function to show relevant screen
  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      // Local storage
      deviceStorage.writeIfNull('isFirstTime', true);
      // check if its the first time launching the app
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen()) // Redirect to Login Screen if not the first time
          : Get.offAll(() => const OnBoardingScreen() // Redirect to OnBoarding Screen if the first time
              );
    }

    // Local Storage debug - when the first time
    if (kDebugMode) {
      print('======== GET STORAGE ========');
      print(deviceStorage.read('isFirstTime'));
    }
  }

  /* ------------------------Email & Password sign in ------------------------ */

  // [EmailAuthentication] - SignIn

  // [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again!';
    }
  }

  // [EmailVerification] - MAIL VERIFICATION

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again!';
    }
  }

  // [ReAuthentication] - ReAuthentication User

  // [EmailAuthentication] - FORGOT PASSWORD

  /* -------------------- Federated identity & social sign-in -------------------- */

  // [GoogleAuthentication] - GOOGLE SIGN IN

  // [FacebookAuthentication] - FACEBOOK SIGN IN

  /* ------------------------ ./end federated identity & social sign-in ------------------------ */

  // [LogoutUser] - Valid for any authenticated user

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again!';
    }
  }

  // DELETE USER - Remove user Auth and Firestore Account
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:red_zone/features/disaster_main/controller/disaster_controller.dart';
import 'package:red_zone/features/disaster_main/controller/disaster_fetch_controller.dart';
import 'package:red_zone/features/previous_disaster/controller/prediction_controller.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';

Future<void> main() async {
  /// Widget Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// GetX Local Storage Initialization
  await GetStorage.init();

  /// Await splash screen until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize the Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  // Initialize the Firebase Disaster Controller
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(DisasterController()),
  );

  // Initialize the Firebase Disaster fetch Controller
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(DisasterFetchController()),
  );

  // Load all the Material Design / Theme / Localizations / Bindings
  runApp(const App());
}

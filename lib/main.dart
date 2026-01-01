import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hf_shop/data/repositories/authentication_repository.dart';
import 'package:hf_shop/features/shop/controllers/home/home_controller.dart';
import 'package:hf_shop/firebase_options.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hf_shop/my_app.dart';

Future<void> main() async {
  // widget flutter binding
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();

  // flutter native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthenticationRepository());
  });

  Get.put(HomeController());
  runApp(const MyApp());
}

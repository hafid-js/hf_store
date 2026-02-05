import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hf_shop/data/repositories/authentication_repository.dart';
import 'package:hf_shop/firebase_options.dart';
import 'package:hf_shop/my_app.dart';
import 'package:hf_shop/utils/constants/keys.dart';

Future<void> main() async {

  
  // widget flutter binding
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();

  // flutter native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await GetStorage.init();

  Stripe.publishableKey = UKeys.stripePublishableKey;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthenticationRepository(), permanent: true);
  });
  runApp(const MyApp());
}

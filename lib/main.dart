import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hf_shop/features/shop/controllers/home/home_controller.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hf_shop/my_app.dart';

void main() {
  // widget flutter binding
  // final widgetBinding = WidgetsFlutterBinding.ensureInitialized();

  // flutter native splash
  // FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(HomeController());
  runApp(const MyApp());

}


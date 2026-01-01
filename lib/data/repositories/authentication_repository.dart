import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hf_shop/features/authentication/screens/login/login.dart';
import 'package:hf_shop/features/authentication/screens/onboarding/onboarding.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final storage = GetStorage();
  @override
  void onReady() {
    FlutterNativeSplash.remove();

    screenRedirect();
  }

  void screenRedirect() {
    storage.writeIfNull('isFirstTime', true);

    storage.read('isFirstTime') != true ? Get.to(() => OnBoardingScreen()) : Get.to(() => LoginScreen());
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hf_shop/features/authentication/screens/login/login.dart';

class OnboardingController extends GetxController {
  
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  RxInt currentIndex = 0.obs;

  void updatePageIndicator(index) {
    currentIndex.value = index;
  }

  void dotNavigationClick(index){
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  void nextPage() {
    if(currentIndex.value == 2) {
      Get.offAll(() => LoginScreen());
      return;
    }
    currentIndex.value++;
    pageController.jumpToPage(currentIndex.value);
  }

  void skipPage() {
    currentIndex.value = 2;
    pageController.jumpToPage(currentIndex.value);
  }

}
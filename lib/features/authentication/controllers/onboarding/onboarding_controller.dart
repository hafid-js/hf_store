import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
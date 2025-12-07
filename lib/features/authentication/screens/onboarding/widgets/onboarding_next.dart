import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hf_shop/common/button/elevated_butto.dart';
import 'package:hf_shop/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(
      left: 0,
      right: 0,
      bottom: USizes.spaceBtwItems / 2,
      child: UElevatedButton(
        onPressed: controller.nextPage,
        child: Obx(
          () =>
              Text(controller.currentIndex.value == 2 ? 'Get Started' : 'Next'),
        ),
      ),
    );
  }
}

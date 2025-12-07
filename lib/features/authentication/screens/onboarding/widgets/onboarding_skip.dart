import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hf_shop/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:hf_shop/utils/constants/helpers/device_helpers.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Obx(
      () => controller.currentIndex.value == 2
          ? SizedBox()
          : Positioned(
              top: UDeviceHelper.getAppBarHeight(),
              right: 0,
              child: TextButton(
                onPressed: controller.skipPage,
                child: Text('Skip'),
              ),
            ),
    );
  }
}

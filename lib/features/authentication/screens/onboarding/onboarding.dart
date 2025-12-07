import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:hf_shop/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:hf_shop/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:hf_shop/features/authentication/screens/onboarding/widgets/onboarding_next.dart';
import 'package:hf_shop/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:hf_shop/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/constants/texts.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Padding(padding: EdgeInsets.symmetric(horizontal: USizes.defaultSpace,), child: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: (value) => controller.updatePageIndicator,
            children: [
              OnBoardingPage(animation: UImages.onBoarding1Animation, title: UTexts.onBoardingTitle1, subTitle: UTexts.onBoardingSubtitle1),
              OnBoardingPage(animation: UImages.onBoarding2Animation, title: UTexts.onBoardingTitle2, subTitle: UTexts.onBoardingSubtitle2),
              OnBoardingPage(animation: UImages.onBoarding3Animation, title: UTexts.onBoardingTitle3, subTitle: UTexts.onBoardingSubtitle3),
            ],
          ),
          // indicator
          OnBoardingDotNavigation(),
          // bottom button
          OnBoardingNextButton(),

          OnBoardingSkipButton()
        ],
      ),)
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final OnboardingController controller =
        Get.put(OnboardingController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: USizes.defaultSpace,
        ),
        child: Stack(
          children: [
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: const [
                OnBoardingPage(
                  animation: UImages.onboarding1Animation,
                  title: UTexts.onBoardingTitle1,
                  subTitle: UTexts.onBoardingSubtitle1,
                ),
                OnBoardingPage(
                  animation: UImages.onboarding2Animation,
                  title: UTexts.onBoardingTitle2,
                  subTitle: UTexts.onBoardingSubtitle2,
                ),
                OnBoardingPage(
                  animation: UImages.onboarding3Animation,
                  title: UTexts.onBoardingTitle3,
                  subTitle: UTexts.onBoardingSubtitle3,
                ),
              ],
            ),

            // indicator
            const OnBoardingDotNavigation(),

            // bottom button
            const OnBoardingNextButton(),

            // skip button
            const OnBoardingSkipButton(),
          ],
        ),
      ),
    );
  }
}

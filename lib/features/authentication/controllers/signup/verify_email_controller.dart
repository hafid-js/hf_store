import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/widgets/screens/succes_screen.dart';
import 'package:hf_shop/data/repositories/authentication_repository.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/texts.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class VerifyEmailController  extends GetxController{
  static VerifyEmailController get instance => Get.find();
  
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      USnackBarHelpers.successSnackBar(title: 'Email Sent', message: 'Please check your inbox and verify your email to continue');
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  void setTimerForAutoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
          title : UTexts.accountCreatedTitle,
          subTitle: UTexts.accountCreatedSubTitle,
          image: UImages.successfulPaymentIcon,
          onTap: () => AuthenticationRepository.instance.screenRedirect(),
        ));
      }
    });
  }

  Future<void> checkEmailVerificationStatus() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if(currentUser != null && currentUser.emailVerified) {
 Get.off(() => SuccessScreen(
          title : UTexts.accountCreatedTitle,
          subTitle: UTexts.accountCreatedSubTitle,
          image: UImages.successfulPaymentIcon,
          onTap: () => AuthenticationRepository.instance.screenRedirect(),
        ));
      }
    } catch(e) {

    }
  }
}
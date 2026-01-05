import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/data/repositories/authentication_repository.dart';
import 'package:hf_shop/features/authentication/screens/forget_password/reset_password.dart';
import 'package:hf_shop/utils/constants/helpers/network_manager.dart';
import 'package:hf_shop/utils/popups/full_screen_loader.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class ForgetPasswordController extends GetxController {

  static ForgetPasswordController get instance => Get.find();


  final email = TextEditingController();
  final forgetPasswordFormKey = GlobalKey<FormState>();

  Future<void> sendPasswordResetEmail() async {
    try {

      UFullScreenLoader.openLoadingDialog('Processing your request...');

      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      if(!forgetPasswordFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
      }

      AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

              UFullScreenLoader.stopLoading();

              USnackBarHelpers.successSnackBar(title: 'Email Sent', message: 'Email link sent to Reset your Password');

              Get.to(() => ResetPasswordScreen(email: email.text.trim(),));

    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Failed Forget Password', message: e.toString());

    }


  }

  Future<void> resendPasswordResetEmail() async {
    try {
      UFullScreenLoader.openLoadingDialog('Processing your request...');

      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }


      AuthenticationRepository.instance.sendPasswordResetEmail(email.text);

      UFullScreenLoader.stopLoading();

      USnackBarHelpers.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your password');
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Failed Forget Password', message: e.toString());
    }
  }

}
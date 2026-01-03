import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/data/repositories/authentication_repository.dart';
import 'package:hf_shop/data/repositories/user/user_repository.dart';
import 'package:hf_shop/features/authentication/models/user_model.dart';
import 'package:hf_shop/features/authentication/screens/signup/verify_email.dart';
import 'package:hf_shop/utils/constants/helpers/network_manager.dart';
import 'package:hf_shop/utils/popups/full_screen_loader.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.put(SignupController());

  final signUpFormKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = false.obs;
  RxBool privacyPolicy = false.obs;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  Future<void> registerUser() async {
    try {
      UFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
      );

      bool isConnected = await Get.put(NetworkManager()).isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      if (!privacyPolicy.value) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account. you must have to read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      if (!signUpFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      UserCredential userCredential = await AuthenticationRepository.instance
          .registerUser(email.text.trim(), password.text.trim());

      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
      }
      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text,
        lastName: lastName.text,
        username: '${firstName.text}${lastName.text}98729372',
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(userModel);

      USnackBarHelpers.successSnackBar(
        title: 'Congratulations!',
        message: 'Your account has been created! Verify email to continue',
      );

      UFullScreenLoader.stopLoading();

      Get.to(() => VerifyEmailScreen(email: email.text,));
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}

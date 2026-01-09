import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/data/repositories/authentication_repository.dart';
import 'package:hf_shop/data/repositories/user/user_repository.dart';
import 'package:hf_shop/features/authentication/models/user_model.dart';
import 'package:hf_shop/features/authentication/screens/login/login.dart';
import 'package:hf_shop/features/personalization/screens/edit_profile/widgets/re_authentication_user_form.dart';
import 'package:hf_shop/utils/constants/helpers/network_manager.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/popups/full_screen_loader.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  RxBool profileLoading = false.obs;
  final networkManager = NetworkManager.instance;

  final email = TextEditingController();
  final password = TextEditingController();
  final reAuthFormKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = false.obs;
  RxBool isProfileUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
      fetchUserDetails();
    ever(networkManager.isConnected, (bool connected) {
      if (!connected) {
        USnackBarHelpers.warningSnackBar(
          title: 'No Internet Connection',
          message: 'Please check your connection',
        );
      }
    });
  }

  Future<void> saveUserRecord(UserCredential userCredential) async {
    try {
      await fetchUserDetails();
      if (user.value.id.isEmpty) {
        final userData = userCredential.user!;
        final displayName = userData.displayName ?? '';
        final nameParts = UserModel.nameParts(displayName);

        final baseUsername = displayName.isNotEmpty
            ? displayName.replaceAll(' ', '').toLowerCase()
            : 'user';

        final username =
            '$baseUsername${DateTime.now().millisecondsSinceEpoch}';

        UserModel userModel = UserModel(
          id: userData.uid,
          firstName: nameParts.isNotEmpty ? nameParts[0] : '',
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userData.email ?? '',
          phoneNumber: userData.phoneNumber ?? '',
          profilePicture: userData.photoURL ?? '',
        );

        await _userRepository.saveUserRecord(userModel);
        this.user(userModel);
      }
      // langsung update state
    } catch (e) {
      USnackBarHelpers.warningSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your information',
      );
    }
  }

  Future<void> fetchUserDetails() async {
    try {
      profileLoading.value = true;
      final userModel = await _userRepository.fetchUserDetails();
      user(userModel);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> handleGoogleLogin(UserCredential userCredential) async {
    await saveUserRecord(userCredential);
    await fetchUserDetails();
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(USizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete account permanently?',
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
        ),
        onPressed: () => deleteUserAccount(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: Text('Cancel'),
      ),
    );
  }

  Future<void> deleteUserAccount() async {
    try {
      UFullScreenLoader.openLoadingDialog('Processing...');

      final authRepository = AuthenticationRepository.instance;
      final provider = authRepository.currentUser!.providerData
          .map((e) => e.providerId)
          .first;

      if (provider == 'google.com') {
        await authRepository.signInWithGoogle();
        await authRepository.deleteAccount();
        UFullScreenLoader.stopLoading();
        Get.offAll(() => LoginScreen());
      } else if (provider == 'password') {
        UFullScreenLoader.stopLoading();
        Get.to(() => ReAuthenticationUserForm());
      }
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> reAuthenticationUser() async {
    try {
      UFullScreenLoader.openLoadingDialog('Processing...');

      bool isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticationUserWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );
      await AuthenticationRepository.instance.deleteAccount();

      UFullScreenLoader.stopLoading();

      Get.offAll(() => LoginScreen());
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    }
  }

  Future<void> updateUserProfilePicture() async {
    try {

      isProfileUploading.value = true;

      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image == null) return;

      File file = File(image.path);

      if(user.value.publicId.isNotEmpty) {
        await _userRepository.deleteProfilePicture(user.value.publicId);
      }

      dio.Response response = await _userRepository.uploadImage(file);
      if (response.statusCode == 200) {
        final data = response.data;
        final imageUrl = data['url'];
        final publicId = data['public_id'];

        await _userRepository.updateSingleField({
          'profilePicture': imageUrl,
          'publicId': publicId,
        });

        user.value.profilePicture = imageUrl;
        user.value.publicId = publicId;

        user.refresh();

        USnackBarHelpers.successSnackBar(
          title: 'Congratulation',
          message: 'Profile picture updated successfully',
        );
      } else {
        throw 'Failed to upload profile picture. Please try again';
      }
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
      isProfileUploading.value = false;
    }
  }
}

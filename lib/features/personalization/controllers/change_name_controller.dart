import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/data/repositories/user/user_repository.dart';
import 'package:hf_shop/features/personalization/controllers/user_controller.dart';
import 'package:hf_shop/navigation_menu.dart';
import 'package:hf_shop/utils/constants/helpers/network_manager.dart';
import 'package:hf_shop/utils/popups/full_screen_loader.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class ChangeNameController extends GetxController {
  static ChangeNameController get instance => Get.find();

  final _userController = UserController.instance;
  final _userRepository = UserRepository.instance;

  final firstName = TextEditingController();
  final lastName = TextEditingController();

  final updateUserFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
   initializedNames();
    super.onInit();
  }

  void initializedNames() {

    firstName.text = _userController.user.value.firstName;
    lastName.text = _userController.user.value.lastName;

  }

  Future<void> updateUserName() async {
    try {
      UFullScreenLoader.openLoadingDialog('We are updating your information...');

      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      if(!updateUserFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

            Map<String, dynamic> map = {'firstName': firstName.text, 'lastName': lastName.text};
      await _userRepository.updateSingleField(map);

      _userController.user.value.firstName = firstName.text;
      _userController.user.value.lastName = lastName.text;

      UFullScreenLoader.stopLoading();

      Get.offAll(() => NavigationMenu());

      USnackBarHelpers.successSnackBar(title: 'Congratulation', message: 'Your name has been updated!');
      
    } catch(e) {
        UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Update Name Failed!', message: e.toString());
    }
  }
}
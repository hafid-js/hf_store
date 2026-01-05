import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/button/social_buttons.dart';
import 'package:hf_shop/common/widgets/login_signup/form_divider.dart';
import 'package:hf_shop/features/authentication/controllers/login/login_controller.dart';
import 'package:hf_shop/features/authentication/screens/login/widgets/login_form.dart';
import 'package:hf_shop/features/authentication/screens/login/widgets/login_header.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/constants/texts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: UPadding.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ULoginHeader(),

            SizedBox(height: USizes.spaceBtwSections),

            ULoginForm(),

            SizedBox(height: USizes.spaceBtwSections),

            UFormDivider(title: UTexts.orSignInWith,),

            SizedBox(height: USizes.spaceBtwSections),

            USocialButtons(),
          ],
        ),
      ),
    );
  }
}
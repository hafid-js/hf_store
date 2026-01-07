import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/button/elevated_button.dart';
import 'package:hf_shop/features/personalization/controllers/user_controller.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/constants/texts.dart';
import 'package:hf_shop/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthenticationUserForm extends StatelessWidget {
  const ReAuthenticationUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Re-Authentication User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.email,
                  validator: UValidator.validateEmail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: UTexts.email,
                  ),
                ),
                Obx(
                  () => TextFormField(
                    controller: controller.password,
                    obscureText: controller.isPasswordVisible.value,
                    validator: (value) =>
                        UValidator.validateEmptyText('Password', value),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      labelText: UTexts.password,
                      suffixIcon: IconButton(
                        onPressed: () => controller.isPasswordVisible.toggle(),
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Iconsax.eye
                              : Iconsax.eye_slash,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: USizes.spaceBtwSections,),

                UElevatedButton(onPressed: controller.reAuthenticationUser, child: Text('Verify')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/button/elevated_button.dart';
import 'package:hf_shop/features/personalization/controllers/change_name_controller.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/constants/texts.dart';
import 'package:hf_shop/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeNameController());
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Update Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update your name to keep your profile accurate and persinalized',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: USizes.spaceBtwSections),

              Form(
                key: controller.updateUserFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) =>
                          UValidator.validateEmptyText('First Name', value),
                      decoration: InputDecoration(
                        labelText: UTexts.firstName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    SizedBox(height: USizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) =>
                          UValidator.validateEmptyText('First Name', value),
                      decoration: InputDecoration(
                        labelText: UTexts.firstName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: USizes.spaceBtwSections),

              UElevatedButton(onPressed: controller.updateUserName, child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}

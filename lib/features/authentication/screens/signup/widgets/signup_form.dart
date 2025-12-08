import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:hf_shop/common/widgets/button/elevated_button.dart';
import 'package:hf_shop/features/authentication/screens/signup/verify_email.dart';
import 'package:hf_shop/features/authentication/screens/signup/widgets/privacy_policy.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/constants/texts.dart';
import 'package:iconsax/iconsax.dart';

class USignupForm extends StatelessWidget {
  const USignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: UTexts.firstName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            ),
            SizedBox(width: USizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: UTexts.lastName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: USizes.spaceBtwInputFields),
    
        TextFormField(
          decoration: InputDecoration(
            labelText: UTexts.email,
            prefixIcon: Icon(Iconsax.direct_right),
          ),
        ),
        SizedBox(height: USizes.spaceBtwInputFields),
        TextFormField(
          decoration: InputDecoration(
            labelText: UTexts.phoneNumber,
            prefixIcon: Icon(Iconsax.direct_right),
          ),
        ),
        SizedBox(height: USizes.spaceBtwInputFields),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Iconsax.password_check),
            labelText: UTexts.password,
            suffixIcon: Icon(Iconsax.eye),
          ),
        ),
    
        SizedBox(height: USizes.spaceBtwInputFields / 2,),
    
        UPolicyPrivacyCheckbox(),
    
        SizedBox(height: USizes.spaceBtwItems,),
        UElevatedButton(onPressed: () => Get.to(() => VerifyEmailScreen()), child: Text(UTexts.createAccount))
      ],
    );
  }
}
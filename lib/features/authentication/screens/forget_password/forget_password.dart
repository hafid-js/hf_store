import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/button/elevated_button.dart';
import 'package:hf_shop/features/authentication/screens/forget_password/reset_password.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/constants/texts.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(UTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium,),
            SizedBox(height: USizes.spaceBtwItems / 2,),
            Text(UTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium,),
            SizedBox(height: USizes.spaceBtwSections * 2),
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: UTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right)
                  ),
                ),

                SizedBox(height: USizes.spaceBtwItems,),

                UElevatedButton(onPressed: () => Get.to(() => ResetPasswordScreen()), child: Text(UTexts.submit))
              ],
            )
          ],
        ),
        ),
      ),
    );
  }
}

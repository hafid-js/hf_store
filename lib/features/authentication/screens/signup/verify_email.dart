import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/button/elevated_button.dart';
import 'package:hf_shop/common/widgets/screens/succes_screen.dart';
import 'package:hf_shop/features/authentication/screens/login/login.dart';
import 'package:hf_shop/utils/constants/helpers/device_helpers.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/constants/texts.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => LoginScreen()),
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              Image.asset(
                UImages.mailSentImage,
                height: UDeviceHelper.getScreenWidth(context) * 0.6,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              Text(
                UTexts.verifyEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              Text(
                'unknown@gmail.com',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              Text(
                UTexts.verifyEmailSubTitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              UElevatedButton(onPressed: () => Get.to(() => SuccessScreen(
                title: UTexts.accountCreatedTitle,
                subTitle: UTexts.accountCreatedSubTitle,
                image: UImages.accountCreatedImage,
                onTap: () {},
              )), child: Text(UTexts.uContinue)),

              SizedBox(
                width: UDeviceHelper.getScreenWidth(context),
                child: TextButton(
                  onPressed: () {},
                  child: Text(UTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

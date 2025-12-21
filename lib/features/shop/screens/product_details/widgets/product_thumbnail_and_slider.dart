import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/icons/circular_icon.dart';
import 'package:hf_shop/common/widgets/images/rounded_image.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class UProductThumbnailAndSlider extends StatelessWidget {
  const UProductThumbnailAndSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Container(
      color: dark ? UColors.darkGrey : UColors.light,
      child: Stack(
        children: [
          SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(USizes.productImageRadius * 2),
              child: Center(
                child: Image(image: AssetImage(UImages.productImage4a)),
              ),
            ),
          ),

          Positioned(
            left: USizes.defaultSpace,
            right: 0,
            bottom: 30,
            child: SizedBox(
              height: 80.0,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: USizes.spaceBtwItems),
                shrinkWrap: true,
                itemBuilder: (context, index) => URoundedImage(
                  width: 80,
                  backgroundColor: dark ? UColors.dark : Colors.white,
                  padding: EdgeInsets.all(USizes.sm),
                  border: Border.all(color: UColors.primary),
                  imageUrl: UImages.productImage2,
                ),
                itemCount: 6,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),

          UAppBar(
            showBackArrow: true,
            actions: [UCircularIcon(icon: Iconsax.heart5, color: Colors.red)],
          ),
        ],
      ),
    );
  }
}
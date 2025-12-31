import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/custom_shapes/rounded_container.dart';
import 'package:hf_shop/common/widgets/icons/circular_icon.dart';
import 'package:hf_shop/common/widgets/images/rounded_image.dart';
import 'package:hf_shop/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:hf_shop/common/widgets/texts/product_price_text.dart';
import 'package:hf_shop/common/widgets/texts/product_title_text.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class UProductCardHorizontal extends StatelessWidget {
  const UProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(USizes.productImageRadius),
        color: dark ? UColors.darkGrey : UColors.white,
      ),
      child: Row(
        children: [
          URoundedContainer(
            height: 120,
            padding: EdgeInsets.all(USizes.sm),
            backgroundColor: dark ? UColors.dark : UColors.light,
            child: Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: URoundedImage(imageUrl: UImages.productImage15),
                ),

                Positioned(
                  top: 12.0,
                  child: URoundedContainer(
                    radius: USizes.sm,
                    backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: USizes.sm,
                      vertical: USizes.xs,
                    ),
                    child: Text(
                      '20%',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge!.apply(color: UColors.black),
                    ),
                  ),
                ),

                Positioned(
                  right: 0,
                  top: 0,
                  child: UCircularIcon(icon: Iconsax.heart5, color: Colors.red),
                ),
              ],
            ),
          ),

          SizedBox(
            width: 170.0,
            child: Padding(
              padding: const EdgeInsets.only(left: USizes.sm, top: USizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UProductTitleText(
                        title: 'Blue Bata Shoes',
                        smallSize: true,
                      ),
                      SizedBox(height: USizes.spaceBtwItems / 2),

                      UBrandTitleWithVerifyIcon(title: 'Bata'),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: UProductPriceText(price: '65'),),
                      Container(
                        width: USizes.iconLg * 1.2,
                        height: USizes.iconLg * 1.2,
                        decoration: BoxDecoration(
                          color: UColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(USizes.cardRadiusMd),
                            bottomRight: Radius.circular(
                              USizes.productImageRadius,
                            ),
                          ),
                        ),
                        child: Icon(Iconsax.add, color: UColors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

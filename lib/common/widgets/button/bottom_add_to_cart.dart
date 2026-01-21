import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/icons/circular_icon.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class UBottomAddToCart extends StatelessWidget {
  const UBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: USizes.defaultSpace,
        vertical: USizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? UColors.darkGrey : UColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(USizes.cardRadiusLg),
          topRight: Radius.circular(USizes.cardRadiusLg),
        ),
      ),
      child: Row(
        children: [
          UCircularIcon(
            icon: Iconsax.minus,
            backgroundColor: UColors.darkGrey,
            width: 40,
            height: 40,
            color: UColors.white,
          ),
          SizedBox(width: USizes.spaceBtwItems),
          Text('2', style: Theme.of(context).textTheme.titleSmall),
          SizedBox(width: USizes.spaceBtwItems),
          UCircularIcon(
            icon: Iconsax.add,
            backgroundColor: UColors.black,
            width: 40,
            height: 40,
            color: UColors.white,
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(USizes.md),
              backgroundColor: UColors.black,
              side: BorderSide(color: UColors.black),
            ),
            child: Row(
              children: [
                Icon(Iconsax.shopping_bag),
                SizedBox(width: USizes.spaceBtwItems / 2),
                Text('Add To Cart'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

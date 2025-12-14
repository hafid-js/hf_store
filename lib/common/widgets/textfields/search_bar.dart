import 'package:flutter/material.dart';
import 'package:hf_shop/common/style/shadow.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/constants/texts.dart';
import 'package:iconsax/iconsax.dart';

class USearchBar extends StatelessWidget {
  const USearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    bool dark = UHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: 0,
      right: USizes.spaceBtwSections,
      left: USizes.spaceBtwSections,
      child: Container(
        height: USizes.searchBarHeight,
        padding: EdgeInsets.symmetric(horizontal: USizes.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(USizes.borderRadiusLg),
          color: dark ? UColors.dark : UColors.light,
          boxShadow: UShadow.searchBarShadow,
        ),
        child: Row(
          children: [
            Icon(Iconsax.search_normal, color: UColors.darkGrey),
            SizedBox(width: USizes.spaceBtwItems),
            Text(
              UTexts.searchBarTitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

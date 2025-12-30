import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/features/personalization/screens/cart/cart.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class UCartCounterIcon extends StatelessWidget {
  const UCartCounterIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    bool dark = UHelperFunctions.isDarkMode(context);
    return Stack(
      children: [
    
        // bag icon / bag icon
        IconButton(
          onPressed: () => Get.to(() => CartScreen()),
          icon: Icon(Iconsax.shopping_bag),
          color: UColors.white,
        ),
    
        // counter text
        Positioned(
          right: 6.0,
          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color: dark ? Colors.black : UColors.light,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.apply(fontSizeFactor: 0.8, color: dark ? UColors.light : UColors.dark,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

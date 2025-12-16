import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/products/cart/cart_counter_icon.dart';
import 'package:hf_shop/common/widgets/textfields/search_bar.dart';
import 'package:hf_shop/features/shop/screens/home/widgets/primary_header_container.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UStorePrimaryHeader extends StatelessWidget {
  const UStorePrimaryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            // total height + 10
            SizedBox(height: USizes.storePrimaryHeaderHeight + 10),
    
            // primary header container
            UPrimaryHeaderContainer(
              height: USizes.storePrimaryHeaderHeight,
              child: UAppBar(
                title: Text(
                  'Store',
                  style: Theme.of(context).textTheme.headlineMedium!
                      .apply(color: UColors.white),
                ),
                actions: [UCartCounterIcon()],
              ),
            ),
    
            USearchBar(),
          ],
        ),
      ],
    );
  }
}

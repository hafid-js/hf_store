import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/products/cart/cart_counter_icon.dart';
import 'package:hf_shop/common/widgets/shimmer/shimmer_effect.dart';
import 'package:hf_shop/features/personalization/controllers/user_controller.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UHomeAppBar extends StatelessWidget {
  const UHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
final controller = UserController.instance;
    return UAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Text(
            UHelperFunctions.getGreetingMessage(),
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: UColors.grey),
          ),
          SizedBox(height: USizes.spaceBtwItems /3),
    
          // subtitle
          Obx(() {
            if(controller.profileLoading.value) {
              return UShimmerEffect(width: 80, height: 15);
            }
            return Text(
            controller.user.value.fullName,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: UColors.white),
          );
          }),
          
        ],
      ),
      actions: [
        UCartCounterIcon(),
      ],
    );
  }
}
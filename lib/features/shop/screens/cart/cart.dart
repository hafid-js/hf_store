import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/button/elevated_button.dart';
import 'package:hf_shop/common/widgets/icons/circular_icon.dart';
import 'package:hf_shop/common/widgets/loaders/animation_loader.dart';
import 'package:hf_shop/features/shop/controllers/cart/cart_controller.dart';
import 'package:hf_shop/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:hf_shop/features/shop/screens/checkout/checkout.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium),
        actions: [UCircularIcon(icon: Iconsax.box_remove, onPressed: () => controller.clearCart(),)],
      ),
      body: Obx(() {
        final emptyWidget = UAnimationLoader(
          text: 'Cart is Empty!',
          animation: UImages.cartEmptyAnimation,
          showActionButton: true,
          actionText: "Let's fill it",
          onActionPressed: Get.back,
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        }
        return SingleChildScrollView(
          child: Padding(padding: UPadding.screenPadding, child: UCartItems()),
        );
      }),

      bottomNavigationBar: Obx(() {
        if (controller.cartItems.isEmpty) return SizedBox();
        return Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: UElevatedButton(
            onPressed: () => Get.to(() => CheckoutScreen()),
            child: Text(
              'Checkout \$${controller.totalCartPrice.value.toStringAsFixed(2)}',
            ),
          ),
        );
      }),
    );
  }
}

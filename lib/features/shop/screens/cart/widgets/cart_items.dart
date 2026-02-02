import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/widgets/products/cart/cart_item.dart';
import 'package:hf_shop/common/widgets/products/cart/product_quantity_with_add_remove.dart';
import 'package:hf_shop/common/widgets/texts/product_price_text.dart';
import 'package:hf_shop/features/shop/controllers/cart/cart_controller.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Obx(() {
      if (controller.cartItems.isEmpty) {
        return const Center(child: Text('Cart masih kosong'));
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) =>
            const SizedBox(height: USizes.spaceBtwSections),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = controller.cartItems[index];

          return Column(
            children: [
              UCartItem(cartItem: cartItem),
              if (showAddRemoveButtons)
                const SizedBox(height: USizes.spaceBtwItems),
              if (showAddRemoveButtons)
                Row(
                  children: [
                    const SizedBox(width: 70.0),
                    UProductQuantityWithAddRemove(
                      quantity: cartItem.quantity,
                      add: () => controller.addOneToCart(cartItem),
                      remove: () => controller.removeOneFromCart(cartItem),
                    ),
                    const Spacer(),
                    UProductPriceText(
                      price: (cartItem.price * cartItem.quantity)
                          .toStringAsFixed(0),
                    ),
                  ],
                ),
            ],
          );
        },
      );
    });
  }
}

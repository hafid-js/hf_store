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
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) =>
          SizedBox(height: USizes.spaceBtwSections),
      itemBuilder: (context, index) {
        return Obx(() {
          final cartItem = controller.cartItems[index];
          return Column(
            children: [
              UCartItem(cartItem: cartItem,),
              if (showAddRemoveButtons) SizedBox(height: USizes.spaceBtwItems),
              if (showAddRemoveButtons)
                Row(
                  children: [
                    SizedBox(width: 70.0),

                    UProductQuantityWithAddRemove(
                      quantity: cartItem.quantity,
                      add: () => controller.addOneToCart(cartItem),
                      remove: () => controller.removeOneFromCart(cartItem)
                    ),
                    Spacer(),
                    UProductPriceText(price: '8.249'),
                  ],
                ),
            ],
          );
        });
      },
      itemCount: controller.cartItems.length,
    );
  }
}

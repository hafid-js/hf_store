import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/button/elevated_button.dart';
import 'package:hf_shop/common/widgets/custom_shapes/rounded_container.dart';
import 'package:hf_shop/common/widgets/screens/succes_screen.dart';
import 'package:hf_shop/common/widgets/textfields/promo_code.dart';
import 'package:hf_shop/features/shop/controllers/cart/cart_controller.dart';
import 'package:hf_shop/features/shop/controllers/order/order_controller.dart';
import 'package:hf_shop/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:hf_shop/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:hf_shop/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:hf_shop/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:hf_shop/navigation_menu.dart';
import 'package:hf_shop/utils/constants/helpers/pricing_calculator.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/constants/texts.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    double subTotal = cartController.totalCartPrice.value;
    double totalPrice = UPricingCalculator.calculateTotalPrice(
      subTotal,
      'Indonesia',
    );
    final orderController = Get.put(OrderController());
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              UCartItems(showAddRemoveButtons: false),
              SizedBox(height: USizes.spaceBtwSections),

              UPromoCodeField(),
              SizedBox(height: USizes.spaceBtwSections),

              URoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(USizes.md),
                backgroundColor: Colors.transparent,
                child: Column(
                  children: [
                    UBillingAmountSection(),
                    SizedBox(height: USizes.spaceBtwItems),
                    UBillingPaymentSection(),
                    SizedBox(height: USizes.spaceBtwItems),
                    UBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: UElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalPrice)
              : USnackBarHelpers.errorSnackBar(
                  title: 'Empty Cart',
                  message: 'Add item in the cart',
                ),
          child: Text('Checkout ${UTexts.currency}$totalPrice'),
        ),
      ),
    );
  }
}

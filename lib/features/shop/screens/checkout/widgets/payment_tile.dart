
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:hf_shop/common/widgets/custom_shapes/rounded_container.dart';
import 'package:hf_shop/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:hf_shop/features/shop/models/payment_method_model.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class UPaymentTile extends StatelessWidget {
  const UPaymentTile({super.key, required this.paymentMethod});

final PaymentMethodModel paymentMethod;
  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      contentPadding: EdgeInsets.zero,
      leading: URoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: UHelperFunctions.isDarkMode(context) ? UColors.light : UColors.white,
        padding: EdgeInsets.all(USizes.sm),
        child: Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain,),
      ),
      title: Text(paymentMethod.name),
      trailing: Icon(Iconsax.arrow_right_34),
    );
  }
}
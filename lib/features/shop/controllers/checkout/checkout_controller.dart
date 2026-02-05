import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/data/services/stripe_services.dart';
import 'package:hf_shop/features/shop/controllers/order/order_controller.dart';
import 'package:hf_shop/features/shop/models/payment_method_model.dart';
import 'package:hf_shop/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:hf_shop/utils/constants/enums.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;
  final _orderController = Get.put(OrderController());
  final _stripeService = Get.put(StripeServices());
  final isPaymentProcessing = false.obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(
      name: 'Cash on Delivert',
      image: UImages.codIcon,
      paymentMethod: PaymentMethods.cashOnDelivery,
    );
    super.onInit();
  }

  Future<void> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(USizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              USectionHeading(
                title: 'Select Payment Method',
                showActionButton: false,
              ),
              SizedBox(height: USizes.spaceBtwSections),
              UPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: 'Cash on Delivery',
                  image: UImages.codIcon,
                  paymentMethod: PaymentMethods.cashOnDelivery,
                ),
              ),
              SizedBox(height: USizes.spaceBtwItems / 2),
              UPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: 'Paypal',
                  image: UImages.paypal,
                  paymentMethod: PaymentMethods.paypal,
                ),
              ),
              SizedBox(height: USizes.spaceBtwItems / 2),
              UPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: 'Credit/Debit Card',
                  image: UImages.creditCard,
                  paymentMethod: PaymentMethods.creditCard,
                ),
              ),
              SizedBox(height: USizes.spaceBtwItems / 2),
              UPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: 'Master Card',
                  image: UImages.masterCard,
                  paymentMethod: PaymentMethods.masterCard,
                ),
              ),
              SizedBox(height: USizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkout(double totalAmount) async {
    try {
      isPaymentProcessing.value = true;
      PaymentMethods paymentMethod = selectedPaymentMethod.value.paymentMethod;

      switch (paymentMethod) {
        case PaymentMethods.creditCard:
          await _stripeService.initPaymentSheet('USD', totalAmount.toInt());
          await _stripeService.showPaymentSheet();

        case PaymentMethods.cashOnDelivery:
          break;

        default:
          throw 'Payment method is not supported';
      }

      isPaymentProcessing.value = false;

      await _orderController.processOrder(totalAmount);
    } catch (e) {
      isPaymentProcessing.value = false;
      USnackBarHelpers.errorSnackBar(title: 'Error!', message: e.toString());
    }
  }
}

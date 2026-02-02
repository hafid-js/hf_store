import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/common/widgets/screens/succes_screen.dart';
import 'package:hf_shop/data/repositories/authentication_repository.dart';
import 'package:hf_shop/data/repositories/order/order_repository.dart';
import 'package:hf_shop/features/personalization/controllers/address_controller.dart';
import 'package:hf_shop/features/shop/controllers/cart/cart_controller.dart';
import 'package:hf_shop/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:hf_shop/features/shop/models/order_model.dart';
import 'package:hf_shop/navigation_menu.dart';
import 'package:hf_shop/utils/constants/enums.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/popups/full_screen_loader.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;

  final checkoutController = CheckoutController.instance;

  final addressController = AddressController.instance;

  final _repository = Get.put(OrderRepository());

  Future<void> processOrder(double totalAmount) async {
    try {
      UFullScreenLoader.openLoadingDialog('Processing your order...');

      String userId = AuthenticationRepository.instance.currentUser!.uid;
      if (userId.isEmpty) return;

      OrderModel order = OrderModel(
        id: UniqueKey().toString(),
        status: OrderStatus.pending,
        items: cartController.cartItems.toList(),
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        userId: userId,
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
      );

      await _repository.saveOrder(order);

      cartController.clearCart();

      Get.to(
        () => SuccessScreen(
          title: 'Payment Success!',
          subTitle: 'Your item will be shipped soon!',
          image: UImages.successfulPaymentIcon,
          onTap: () => Get.offAll(() => NavigationMenu()),
        ),
      );
    } catch (e) {
      USnackBarHelpers.errorSnackBar(
        title: 'Order Failed!',
        message: e.toString(),
      );
    }
  }


  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final orders = _repository.fetchUserOrders();
      return orders;
    } catch(e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return[];
    }
  }
}

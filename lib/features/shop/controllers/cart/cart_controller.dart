import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/data/repositories/authentication_repository.dart';
import 'package:hf_shop/features/shop/controllers/product/variation_controller.dart';
import 'package:hf_shop/features/shop/models/cart_item_model.dart';
import 'package:hf_shop/features/shop/models/payment_method_model.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/features/shop/models/product_variation_model.dart';
import 'package:hf_shop/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:hf_shop/utils/constants/enums.dart';
import 'package:hf_shop/utils/constants/keys.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final _storage = GetStorage(
    AuthenticationRepository.instance.currentUser!.uid,
  );
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  final variationController = VariationController.instance;

 CartController() {
  loadCartItems();
 }

  void loadCartItems() {
    List<dynamic>? storedCartItems = _storage.read(UKeys.cartItemsKey);
    if (storedCartItems != null) {
      cartItems.assignAll(
        storedCartItems.map(
          (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
        ),
      );
      updateCartTotals();
    }
  }

  void addToCart(ProductModel product) {
    if (productQuantityInCart < 1) {
      USnackBarHelpers.customToast(message: 'Select Quantity');
      return;
    }

    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      USnackBarHelpers.warningSnackBar(
        title: 'Out Of Stock',
        message: 'This Variation is out of stock',
      );
      return;
    } else {
      if (product.stock < 1) {
        USnackBarHelpers.warningSnackBar(
          title: 'Out Of Stock',
          message: 'This Product is out of stock',
        );
      }
    }

    CartItemModel selectedCartItem = convertToCartItem(
      product,
      productQuantityInCart.value,
    );

    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == selectedCartItem.productId &&
          selectedCartItem.variationId == cartItem.variationId,
    );

    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();

    USnackBarHelpers.customToast(
      message: 'Your product has been added to Cart',
    );
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          item.productId == cartItem.productId &&
          item.variationId == cartItem.variationId,
    );

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          item.productId == cartItem.productId &&
          item.variationId == cartItem.variationId,
    );

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
    }
    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        USnackBarHelpers.customToast(message: 'Product removed from cart');
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  int getProductQuantityInCart(String productId) {
    final itemQuantity = cartItems
        .where((cartItem) => cartItem.productId == productId)
        .fold(
          0,
          (previousValue, cartItems) => previousValue + cartItems.quantity,
        );
    return itemQuantity;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    CartItemModel cartItemModel = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );
    return cartItemModel.quantity;
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void saveCartItems() {
    List<Map<String, dynamic>> cartItemsList = cartItems
        .map((item) => item.toJson())
        .toList();
    _storage.write(UKeys.cartItemsKey, cartItemsList);
  }

  void updateCartTotals() {
    double calculateTotalPrice = 0.0;
    int calculateNoOfItems = 0;

    for (final item in cartItems) {
      calculateTotalPrice += (item.price) * item.quantity.toDouble();
      calculateNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculateTotalPrice;
    noOfCartItems.value = calculateNoOfItems;
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }

    ProductVariationModel variation =
        variationController.selectedVariation.value;
    bool isVariation = variation.id.isNotEmpty;
    String image = isVariation ? variation.image : product.thumbnail;
    double safePrice(double? sale, double? base) {
      final s = sale ?? 0.0;
      final b = base ?? 0.0;
      return s > 0.0 ? s : b;
    }

    double price = isVariation
        ? safePrice(variation.salePrice, variation.price)
        : safePrice(product.salePrice, product.price);

    return CartItemModel(
      productId: product.id,
      quantity: quantity,
      title: product.title,
      brandName: product.brand != null ? product.brand!.name : '',
      image: image,
      price: price,
      selectedVariation: isVariation ? variation.attributeValues : null,
      variationId: variation.id,
    );
  }

  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      String variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value = getVariationQuantityInCart(
          product.id,
          variationId,
        );
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }
  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}

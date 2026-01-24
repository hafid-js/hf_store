import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {};

    images.add(product.thumbnail);

    selectedProductImage.value = product.thumbnail;

    if (product.images != null && product.images!.isNotEmpty) {
      images.addAll(product.images!);
    }

    if (product.productVariations != null &&
        product.productVariations!.isNotEmpty) {
      List<String> variationImages = product.productVariations!
          .map((variation) => variation.image)
          .whereType<String>()
          .toList();
      images.addAll(variationImages);
    }

    return images.toList();
  }

  void showEnlargeImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: USizes.defaultSpace * 2,
                horizontal: USizes.defaultSpace,
              ),
              child: CachedNetworkImage(imageUrl: image),
            ),
            SizedBox(height: USizes.spaceBtwSections),

            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: Get.back,
                  child: const Text("Close"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

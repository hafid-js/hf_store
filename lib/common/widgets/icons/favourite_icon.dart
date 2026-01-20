import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:hf_shop/common/widgets/icons/circular_icon.dart';
import 'package:hf_shop/features/shop/controllers/product/favourite_controller.dart';
import 'package:iconsax/iconsax.dart';

class UFavouriteIcon extends StatelessWidget {
  const UFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Obx(() => UCircularIcon(
      icon: controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart,
      color: controller.isFavourite(productId) ? Colors.red : null,
      onPressed: () => controller.toggleFavouriteProduct(productId),
    ));
  }
}

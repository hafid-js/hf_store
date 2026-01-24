import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/icons/favourite_icon.dart';
import 'package:hf_shop/common/widgets/images/rounded_image.dart';
import 'package:hf_shop/features/shop/controllers/product/image_controller.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UProductThumbnailAndSlider extends StatelessWidget {
  const UProductThumbnailAndSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);
    return Container(
      color: dark ? UColors.darkGrey : UColors.light,
      child: Stack(
        children: [
          SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(USizes.productImageRadius * 2),
              child: Center(
                child: Obx(() {
                  final image = controller.selectedProductImage.value;
                  return GestureDetector(
                  onTap: () => controller.showEnlargeImage(image),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    progressIndicatorBuilder: (context, url, progress) =>
                        CircularProgressIndicator(
                          color: UColors.primary,
                          value: progress.progress,
                        ),
                  ),
                  );
                }),
              ),
            ),
          ),

          Positioned(
            left: USizes.defaultSpace,
            right: 0,
            bottom: 30,
            child: SizedBox(
              height: 80.0,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: USizes.spaceBtwItems),
                shrinkWrap: true,
                itemBuilder: (context, index) => Obx(() {
                  bool isImageSelected = controller.selectedProductImage.value == images[index];
                  return URoundedImage(
                  isNetworkImage: true,
                  onTap: () => controller.selectedProductImage.value = images[index],
                  width: 80,
                  backgroundColor: dark ? UColors.dark : Colors.white,
                  padding: EdgeInsets.all(USizes.sm),
                  border: Border.all(color: isImageSelected ? UColors.primary : UColors.transparent),
                  imageUrl: images[index],
                );
                }),
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),

          UAppBar(
            showBackArrow: true,
            actions: [UFavouriteIcon(productId: product.id)],
          ),
        ],
      ),
    );
  }
}

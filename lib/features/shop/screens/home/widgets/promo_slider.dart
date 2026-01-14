import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/widgets/images/rounded_image.dart';
import 'package:hf_shop/common/widgets/shimmer/shimmer_effect.dart';
import 'package:hf_shop/features/shop/controllers/banner/banner_controller.dart';
import 'package:hf_shop/features/shop/screens/home/widgets/banners_dot_navigation.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UPromoSlider extends StatelessWidget {
  const UPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerController = Get.put(BannerController());

    return Obx(() {

      if(bannerController.isLoading.value) {
        return UShimmerEffect(width: double.infinity, height: 190);
      }

      if(bannerController.banners.isEmpty) {
        return Text('Banners Not Found');
      }

      return Column(
        children: [
          CarouselSlider(
            items: bannerController.banners
                .map(
                  (banner) => URoundedImage(
                    imageUrl: banner.imageUrl,
                    isNetworkImage: true,
                    onTap: () => Get.toNamed(banner.targetScreen),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              onPageChanged: (index, reason) => bannerController.onPageChanged(index),
            ),
            carouselController: bannerController.carouselController,
          ),

          SizedBox(height: USizes.spaceBtwItems),

          BannersDotNavigation(),
        ],
      );
    });
  }
}

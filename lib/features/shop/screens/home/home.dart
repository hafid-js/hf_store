import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/common/widgets/layouts/grid_layout.dart';
import 'package:hf_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:hf_shop/common/widgets/textfields/search_bar.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/shop/screens/all_products/all_products.dart';
import 'package:hf_shop/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:hf_shop/features/shop/screens/home/widgets/home_categories.dart';
import 'package:hf_shop/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:hf_shop/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        children: [
          Stack(
            children: [
              // total height + 10
              SizedBox(height: USizes.homePrimaryHeaderHeight + 10),

              // primary header container
              UPrimaryHeaderContainer(
                height: USizes.homePrimaryHeaderHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UHomeAppBar(),
                    SizedBox(height: USizes.spaceBtwSections),

                    // home categories
                    UHomeCategories(),
                  ],
                ),
              ),

              USearchBar(),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(USizes.defaultSpace),
            child: Column(
              children: [
                UPromoSlider(
                  banners: [
                    UImages.homeBanner1,
                    UImages.homeBanner2,
                    UImages.homeBanner3,
                    UImages.homeBanner4,
                    UImages.homeBanner5,
                  ],
                ),

                SizedBox(height: USizes.spaceBtwSections),

                // section heading
                USectionHeading(title: 'Popular Products', onPressed: () => Get.to(() => AllProductsScreen()),),
                const SizedBox(height: USizes.spaceBtwItems),

                // grid view of product cards
                UGridLayout(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return UProductCardVertical();
                  },
                )
              ],
            ),
          ),
        ],
      ),
      )
    );
  }
}
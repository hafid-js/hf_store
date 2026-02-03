import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/widgets/image_text/vertical_image_text.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/shop/controllers/brand/brand_controller.dart';
import 'package:hf_shop/features/shop/models/brand_model.dart';
import 'package:hf_shop/features/shop/screens/all_brands/all_brands.dart';
import 'package:hf_shop/features/shop/screens/all_brands/brand_products.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class SearchStoreBrands extends StatelessWidget {
  const SearchStoreBrands({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    bool dark = UHelperFunctions.isDarkMode(context);
    return Obx(() {


      if(controller.isLoading.value) return Center(child: CircularProgressIndicator(),);

      if(controller.allBrands.isEmpty) return Text("No Brands Found!");

      List<BrandModel> brands = controller.allBrands.take(10).toList();
      return Column(
      children: [
        USectionHeading(title: 'Brands', onPressed: () => Get.to(() => BrandScreen()),),
        SizedBox(height: USizes.spaceBtwItems),
        Wrap(
          spacing: USizes.spaceBtwItems,
          runSpacing: USizes.spaceBtwItems,
          children: brands.map((brand) => UVerticalImageText(
            onTap: () => Get.to(() => BrandProductsScreen(title: brand.name, brand: brand)),
            title: brand.name, image: brand.image, textColor: dark ? UColors.white : UColors.black)).toList(),
        ),
      ],
    );
    });
  }
}
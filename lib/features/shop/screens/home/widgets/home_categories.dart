import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/widgets/image_text/vertical_image_text.dart';
import 'package:hf_shop/common/widgets/shimmer/category_shimmer.dart';
import 'package:hf_shop/features/shop/controllers/category/category_controller.dart';
import 'package:hf_shop/features/shop/models/category_model.dart';
import 'package:hf_shop/features/shop/screens/sub_category/sub_category.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/constants/texts.dart';

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Padding(
      padding: const EdgeInsets.only(left: USizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // section heading
          Text(
            UTexts.popularCategories,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: UColors.white),
          ),
          SizedBox(height: USizes.spaceBtwItems),

          // categories listview
          Obx(() {

            final categories = controller.featuredCategories;

            if(controller.isCategoriesLoading.value) {
              return UCategoryShimmer(itemCount: 6,);
            }

            if(categories.isEmpty) {
              return Text('Categories Not Found');
            }
            return SizedBox(
            height: 82,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: USizes.spaceBtwItems,),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                CategoryModel category = categories[index];
                return UVerticalImageText(
                  title: category.name,
                  image: category.image,
                  textColor: UColors.white,
                  onTap: () => Get.to(() => SubCategoryScreen()),
                );
              },
            ),
          );
          })
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/widgets/images/rounded_image.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/shop/controllers/category/category_controller.dart';
import 'package:hf_shop/features/shop/models/category_model.dart';
import 'package:hf_shop/features/shop/screens/all_products/all_products.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class SearchStoreCategories extends StatelessWidget {
  const SearchStoreCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Obx(() {
      if (controller.isCategoriesLoading.value) return Center(child: CircularProgressIndicator());

      if (controller.allCategories.isEmpty) return Center(child: Text('No Categories Found!'));

      List<CategoryModel> categories = controller.allCategories;
      return Column(
        children: [
          USectionHeading(title: 'Categories', showActionButton: false,),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              CategoryModel category = categories[index];
              return ListTile(
                onTap: () => Get.to(
                  () => AllProductsScreen(
                    title: category.name,
                    futureMethod: controller.getCategoryProducts(
                      categoryId: category.id,
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                leading: URoundedImage(
                  imageUrl: category.image,
                  borderRadius: 0,
                  width: USizes.iconLg,
                  height: USizes.iconLg,
                  isNetworkImage: true,
                ),
                title: Text(category.name),
              );
            },
            itemCount: 20,
          ),
        ],
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:hf_shop/common/widgets/layouts/grid_layout.dart';
import 'package:hf_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:hf_shop/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/shop/controllers/category/category_controller.dart';
import 'package:hf_shop/features/shop/models/category_model.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/features/shop/screens/all_products/all_products.dart';
import 'package:hf_shop/features/shop/screens/store/widgets/category_brands.dart';
import 'package:hf_shop/utils/constants/helpers/cloud_helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UCategoryTab extends StatelessWidget {
  const UCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrands(category: category),
              SizedBox(height: USizes.spaceBtwItems),
              USectionHeading(
                title: 'You might like',
                onPressed: () => Get.to(
                  () => AllProductsScreen(
                    title: category.name,
                    futureMethod: controller.getCategoryProducts(
                      categoryId: category.id,
                      limit: -1,
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {

                  const loader = UVerticalProductShimmer();
                  final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if(widget != null) return widget;


                  List<ProductModel> products = snapshot.data!;
                  return UGridLayout(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      ProductModel product = products[index];
                      return UProductCardVertical(
                        product: product,
                      );
                    },
                  );
                },
              ),

              SizedBox(height: USizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:hf_shop/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/shop/controllers/category/category_controller.dart';
import 'package:hf_shop/features/shop/models/category_model.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/features/shop/screens/all_products/all_products.dart';
import 'package:hf_shop/utils/constants/helpers/cloud_helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {
                  const loader = UHorizontalProductShimmer();
                  final widget = UCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );
                  if (widget != null) return widget;

                  List<CategoryModel> subCategories = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      CategoryModel subCategory = subCategories[index];
                      return FutureBuilder(
                        future: controller.getCategoryProducts(
                          categoryId: subCategory.id,
                        ),
                        builder: (context, snapshot) {
                          const loader = UHorizontalProductShimmer();
                          final widget =
                              UCloudHelperFunctions.checkMultiRecordState(
                                snapshot: snapshot,
                                loader: loader,
                              );

                          if (widget != null) return widget;

                          List<ProductModel> products = snapshot.data!;
                          if (widget != null) return widget;
                          return Column(
                            children: [
                              USectionHeading(
                                title: subCategory.name,
                                onPressed: () => Get
                                  ..to(
                                    () => AllProductsScreen(
                                      title: subCategory.name,
                                      futureMethod: controller
                                          .getCategoryProducts(
                                            categoryId: subCategory.id,
                                            limit: -1,
                                          ),
                                    ),
                                  ),
                              ),
                              SizedBox(height: USizes.spaceBtwItems / 2),

                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: USizes.spaceBtwItems / 2),
                                  itemCount: products.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    ProductModel product = products[index];
                                    return UProductCardHorizontal(
                                      product: product,
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/layouts/grid_layout.dart';
import 'package:hf_shop/features/shop/controllers/product/product_controller.dart';
import 'package:hf_shop/features/shop/screens/search_store/widgets/search_store_brands.dart';
import 'package:hf_shop/features/shop/screens/search_store/widgets/search_store_categories.dart';
import 'package:hf_shop/utils/constants/helpers/cloud_helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class SearchStoreScreen extends StatelessWidget {
  const SearchStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxString searchText = ''.obs;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.search_normal),
                  hintText: 'Search in store',
                ),
                onChanged: (value) => searchText.value = value,
              ),
              SizedBox(height: USizes.spaceBtwSections),

              Obx(() {
                if (searchText.value.isEmpty) {
                  return Column(
                    children: [
                      SearchStoreBrands(),

                      SizedBox(height: USizes.spaceBtwSections),

                      SearchStoreCategories(),
                    ],
                  );
                }

                return FutureBuilder(
                  future: ProductController.instance.getAllProducts(),
                  builder: (context, snapshot) {
                    final widget = UCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                    );
                    if (widget != null) return widget;

                    final products = snapshot.data!;

                    final filteredProducts = products
                        .where(
                          (product) => product.title.toLowerCase().contains(
                            searchText.value.toLowerCase(),
                          ),
                        )
                        .toList();
                        
                    return UGridLayout(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return Text(product.title);
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/brands/brand_card.dart';
import 'package:hf_shop/common/widgets/layouts/grid_layout.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/shop/controllers/brand/brand_controller.dart';
import 'package:hf_shop/features/shop/screens/all_brands/brand_products.dart';
import 'package:hf_shop/features/shop/models/brand_model.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              USectionHeading(title: 'Brands', showActionButton: false),
              SizedBox(height: USizes.spaceBtwItems),
              

              Obx(() {

                if(controller.isLoading.value) {
                                  return Center(child: CircularProgressIndicator(),);
                                }

                                if(controller.featuredBrands.isEmpty) {
                                  return Center(child: Text('Brands Not Found!'));
                                }
                return UGridLayout(
                  itemCount: controller.allBrands.length,
                  itemBuilder: (context, index) {
                    BrandModel brand = controller.allBrands[index];
                    return UBrandCard(
                      onTap: () => Get.to(() => BrandProductsScreen(title: brand.name, brand: brand,)),
                      brand: brand,
                    );
                  },
                  mainAxisExtent: 80,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

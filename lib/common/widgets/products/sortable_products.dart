import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/widgets/layouts/grid_layout.dart';
import 'package:hf_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:hf_shop/features/shop/controllers/product/all_product_controller.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class USortableProducts extends StatelessWidget {
  const USortableProducts({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = AllProductController.instance;
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownButtonFormField(
          value: controller.selectedSortOption.value,
          onChanged: (value) => controller.sortProducts(value!),
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: ['Name', 'Lower Price', 'Higher Price', 'Sale', 'Newest'].map((
            filter,
          ) {
            return DropdownMenuItem(value: filter, child: Text(filter));
          }).toList(),
        ),

        SizedBox(height: USizes.spaceBtwSections),
       Obx(() =>  UGridLayout(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return UProductCardVertical(product: controller.products[index]);
          },
        ),)
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/brands/brand_card.dart';
import 'package:hf_shop/common/widgets/layouts/grid_layout.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/shop/screens/all_brands/brand_products.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Brand', style: Theme.of(context).textTheme.headlineSmall,),
      ),

      body: SingleChildScrollView(
        child: Padding(padding: UPadding.screenPadding,
        child: Column(
          children: [
            USectionHeading(title: 'Brands', showActionButton: false,),
            SizedBox(height: USizes.spaceBtwItems,),

            UGridLayout(itemCount: 10, itemBuilder: (context, index) => UBrandCard(onTap: () => Get.to(() => BrandProductsScreen()),), mainAxisExtent: 80,)
          ],
        ),),
      ),
    );
  }
}
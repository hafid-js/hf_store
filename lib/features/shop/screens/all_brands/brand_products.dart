import 'package:flutter/material.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/brands/brand_card.dart';
import 'package:hf_shop/common/widgets/products/sortable_products.dart';
import 'package:hf_shop/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:hf_shop/features/shop/controllers/brand/brand_controller.dart';
import 'package:hf_shop/features/shop/models/brand_model.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/utils/constants/helpers/cloud_helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.title, required this.brand});

  final String title;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: UPadding.screenPadding,
        child: Column(
          children: [
            UBrandCard(brand: brand,),
            SizedBox(height: USizes.spaceBtwSections,),
            FutureBuilder(future: controller.getBrandProducts(brand.id), builder: (context, snapshot) {


              const loader = UVerticalProductShimmer();

              Widget? widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
              if(widget != null) return widget;

              List<ProductModel> products = snapshot.data!;
              return USortableProducts(products: products,);
            })
          ],
        ),),
      ),
    );
  }
}
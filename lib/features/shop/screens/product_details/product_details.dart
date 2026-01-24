import 'package:flutter/material.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/button/elevated_button.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/shop/controllers/product/product_controller.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/common/widgets/button/bottom_add_to_cart.dart';
import 'package:hf_shop/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:hf_shop/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:hf_shop/features/shop/screens/product_details/widgets/product_thumbnail_and_slider.dart';
import 'package:hf_shop/utils/constants/enums.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UProductThumbnailAndSlider(product: product,),
            Padding(
              padding: UPadding.screenPadding,
              child: Column(
                children: [
                  UProductMetaData(product: product,),
                  SizedBox(height: USizes.spaceBtwSections),

                 if(product.productType == ProductType.variable.toString())...[
                   UProductAttributes(product: product,),

                  SizedBox(height: USizes.spaceBtwSections),
                 ],

                  UElevatedButton(onPressed: () {}, child: Text('Checkout')),
                  SizedBox(height: USizes.spaceBtwSections),

                  USectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  SizedBox(height: USizes.spaceBtwItems),


                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show More',
                    trimExpandedText: ' Less',
                    moreStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(height: USizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: UBottomAddToCart(),
    );
  }
}

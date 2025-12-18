import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/brands/brand_showcase.dart';
import 'package:hf_shop/common/widgets/layouts/grid_layout.dart';
import 'package:hf_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UCategoryTab extends StatelessWidget {
  const UCategoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
      child: Column(
        children: [
          UBrandShowcase(
            images: [
              UImages.productImage47,
              UImages.productImage43,
              UImages.productImage7,
            ],
          ),
           UBrandShowcase(
            images: [
              UImages.productImage47,
              UImages.productImage43,
              UImages.productImage7,
            ],
          ),
          SizedBox(height: USizes.spaceBtwItems,),
          USectionHeading(title: 'You might like', onPressed: () {},),
          UGridLayout(itemCount: 4, itemBuilder: (context, index) {
            return UProductCardVertical();
          }),

          SizedBox(height: USizes.spaceBtwSections,)
        ],
      ),
    ),
      ],
    );
  }
}
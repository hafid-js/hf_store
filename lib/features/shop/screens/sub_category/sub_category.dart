import 'package:flutter/material.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Sports', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              USectionHeading(title: 'Sports Shoes', onPressed: () {}),
              SizedBox(height: USizes.spaceBtwItems / 2),

              SizedBox(
                height: 120,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      SizedBox(width: USizes.spaceBtwItems / 2),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return UProductCardHorizontal();
                  },
                ),
              ),

              USectionHeading(title: 'Sports Shoes', onPressed: () {}),
              SizedBox(height: USizes.spaceBtwItems / 2),

              SizedBox(
                height: 120,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      SizedBox(width: USizes.spaceBtwItems / 2),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return UProductCardHorizontal();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

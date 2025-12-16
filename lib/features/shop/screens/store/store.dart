import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/brands/brand_card.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/shop/screens/store/widgets/store_primary_header.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innnerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 420,
              pinned: true,
              flexibleSpace: Column(
                children: [
                  // primary header
                  UStorePrimaryHeader(),
                  SizedBox(height: USizes.spaceBtwItems,),

                  // brands heading
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: USizes.defaultSpace,
                    ),
                    child: Column(
                      children: [
                        USectionHeading(title: 'Brands', onPressed: () {}),

                        // brand card
                        SizedBox(
                          height: USizes.brandCardHeight,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(width: USizes.spaceBtwItems),
                            shrinkWrap: true,
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => UBrandCard(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: Container(),
      ),
    );
  }
}

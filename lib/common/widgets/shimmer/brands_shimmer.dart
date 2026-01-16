import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/shimmer/shimmer_effect.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UBrandsShimmer extends StatelessWidget {
  const UBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) =>
          const UShimmerEffect(width: USizes.brandCardWidth, height: USizes.brandCardHeight),
      separatorBuilder: (context, index) =>
          SizedBox(width: USizes.spaceBtwItems),
      itemCount: itemCount,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
    );
  }
}

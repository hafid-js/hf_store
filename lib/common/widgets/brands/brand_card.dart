import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/custom_shapes/rounded_container.dart';
import 'package:hf_shop/common/widgets/images/rounded_image.dart';
import 'package:hf_shop/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:hf_shop/features/shop/models/brand_model.dart';
import 'package:hf_shop/utils/constants/enums.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UBrandCard extends StatelessWidget {
  const UBrandCard({super.key, this.showBorder = true, this.onTap, required this.brand});

  final bool showBorder;
  final VoidCallback? onTap;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: URoundedContainer(
   
        height: USizes.brandCardHeight,
        // height: 170.0,
        showBorder: showBorder,
        padding: EdgeInsets.all(USizes.sm),
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            // brand image
            Flexible(
              child: URoundedImage(
                imageUrl: brand.image,
               isNetworkImage:
      brand.image.isNotEmpty && brand.image.startsWith('http'),
              ),
            ),
            SizedBox(width: USizes.spaceBtwItems / 2),

            // right portion
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // brand name & verify icon
                  UBrandTitleWithVerifyIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),

                  // text
                  Text(
                    '${brand.productsCount} product',
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

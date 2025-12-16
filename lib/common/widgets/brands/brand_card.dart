import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/custom_shapes/rounded_container.dart';
import 'package:hf_shop/common/widgets/images/rounded_image.dart';
import 'package:hf_shop/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:hf_shop/utils/constants/enums.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UBrandCard extends StatelessWidget {
  const UBrandCard({super.key});

  @override
  Widget build(BuildContext context) {
    return URoundedContainer(
      width: USizes.brandCardWidth,
      // height: 170.0,
      showBorder: true,
      padding: EdgeInsets.all(USizes.sm),
      backgroundColor: Colors.transparent,
      child: Row(
        children: [
          // brand image
          Flexible(
            child: URoundedImage(
              imageUrl: UImages.bataLogo,
              backgroundColor: Colors.transparent,
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
                  title: 'Bata',
                  brandTextSize: TextSizes.large,
                ),

                // text
                Text(
                  '175 Products',
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

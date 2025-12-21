import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/custom_shapes/rounded_container.dart';
import 'package:hf_shop/common/widgets/images/circular_image.dart';
import 'package:hf_shop/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:hf_shop/common/widgets/texts/product_price_text.dart';
import 'package:hf_shop/common/widgets/texts/product_title_text.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UProductMetaData extends StatelessWidget {
  const UProductMetaData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              URoundedContainer(
                radius: USizes.sm,
                backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                padding: const EdgeInsets.symmetric(
                  horizontal: USizes.sm,
                  vertical: USizes.xs,
                ),
                child: Text(
                  '20%',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.apply(color: UColors.black),
                ),
              ),
    
              SizedBox(width: USizes.spaceBtwItems),
    
              Text(
                '\$256',
                style: Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
    
              SizedBox(width: USizes.spaceBtwItems),
    
              UProductPriceText(price: '1500', isLarge: true),
    
              Spacer(),
    
              IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            ],
          ),
    
          SizedBox(height: USizes.spaceBtwItems / 1.5),
    
          UProductTitleText(title: 'Apple iPhone 13'),
    
          SizedBox(height: USizes.spaceBtwItems / 1.5),
    
          Row(
            children: [
              UProductTitleText(title: 'Status'),
              SizedBox(width: USizes.spaceBtwItems),
              Text(
                'Out of Stock',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
    
          SizedBox(height: USizes.spaceBtwItems / 1.5),
    
          Row(
            children: [
              UCircularImage(
                padding: 0,
                image: UImages.appleLogo,
                width: 32.0,
                height: 32.0,
              ),
              SizedBox(width: USizes.spaceBtwItems),
              UBrandTitleWithVerifyIcon(title: 'Apple'),
            ],
          ),
        ]
    );
  }
}

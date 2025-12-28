import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/custom_shapes/rounded_container.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class USingleAddress extends StatelessWidget {
  const USingleAddress({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return URoundedContainer(
      showBorder: true,
      backgroundColor: isSelected
          ? UColors.primary.withValues(alpha: 0.5)
          : Colors.transparent,
      borderColor: isSelected
          ? Colors.transparent
          : dark
          ? UColors.darkGrey
          : UColors.grey,
      padding: EdgeInsets.all(USizes.md),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: USizes.spaceBtwItems / 2),
              Text(
                '+62322675455',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: USizes.spaceBtwItems / 2),

              Text('Jl.Balap Sepeda No.27, Pulogadung, East Jakarta'),
            ],
          ),

          if (isSelected)
            Positioned(
              top: 0,
              bottom: 0,
              right: 6,
              child: Icon(Iconsax.tick_circle5),
            ),
        ],
      ),
    );
  }
}

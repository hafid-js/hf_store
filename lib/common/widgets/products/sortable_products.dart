import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/layouts/grid_layout.dart';
import 'package:hf_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class USortableProducts extends StatelessWidget {
  const USortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          onChanged: (value) {},
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: ['Name', 'Lower Price', 'Higher Price', 'Sale', 'Newest']
              .map((filter) {
                return DropdownMenuItem(
                  value: filter,
                  child: Text(filter),
                );
              })
              .toList(),
        ),
    
        SizedBox(height: USizes.spaceBtwSections),
    
        UGridLayout(
          itemCount: 10,
          itemBuilder: (context, inedx) => UProductCardVertical(),
        ),
      ],
    );
  }
}

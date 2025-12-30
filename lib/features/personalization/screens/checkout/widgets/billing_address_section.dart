import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UBillingAddressSection extends StatelessWidget {
  const UBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        USectionHeading(title: 'Billing Address', buttonTitle: 'Change', onPressed: () {},),
        Text('Hafid Tech', style: Theme.of(context).textTheme.titleLarge,),
  SizedBox(width: USizes.spaceBtwItems / 2),
        Row(
          children: [
            Icon(Icons.phone, size: USizes.iconSm, color: UColors.darkGrey,),
            SizedBox(width: USizes.spaceBtwItems,),
            Text('+6288298654539')
          ],
        ),
  SizedBox(width: USizes.spaceBtwItems / 2),
        Row(
          children: [
            Icon(Icons.location_history, size: USizes.iconSm, color: UColors.darkGrey,),
            SizedBox(width: USizes.spaceBtwItems,),
            Expanded(child: Text('Jl.Asia-Afrika No.299, Central Jakarta, Indonesia', softWrap: true,))
          ],
        )

      ],
    );
  }
}
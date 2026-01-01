import 'package:flutter/material.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UBillingAmountSection extends StatelessWidget {
  const UBillingAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium,),),
            Spacer(),
            Text('\$8.249', style: Theme.of(context).textTheme.bodyMedium,)
          ],
        ),
        SizedBox(height: USizes.spaceBtwItems / 3,),
        Row(
          children: [
            Expanded(child: Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium,),),
            Spacer(),
            Text('\$8.249', style: Theme.of(context).textTheme.labelLarge)
          ],
        ),
                SizedBox(height: USizes.spaceBtwItems / 3,),
        Row(
          children: [
            Expanded(child: Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium,),),
            Spacer(),
            Text('\$8', style: Theme.of(context).textTheme.labelLarge)
          ],
        ),
                SizedBox(height: USizes.spaceBtwItems / 2,),
        Row(
          children: [
            Expanded(child: Text('Order Total', style: Theme.of(context).textTheme.bodyLarge,),),
            Spacer(),
            Text('\$8.249', style: Theme.of(context).textTheme.titleMedium)
          ],
        )
      ],
    );
  }
}
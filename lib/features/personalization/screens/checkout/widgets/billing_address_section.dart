import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';

class UBillingAddressSection extends StatelessWidget {
  const UBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        USectionHeading(title: 'Billing Address', buttonTitle: 'Change', onPressed: () {},),
        Text('Hafid Tech', style: Theme.of(context),)

      ],
    );
  }
}
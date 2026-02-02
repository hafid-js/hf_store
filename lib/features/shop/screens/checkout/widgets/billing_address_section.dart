import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/personalization/controllers/address_controller.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UBillingAddressSection extends StatelessWidget {
  const UBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        USectionHeading(
          title: 'Billing Address',
          buttonTitle: 'Change',
          onPressed: () => controller.selectNewAddressBottomSheet(context),
        ),

        Obx(() {
          final address = controller.selectedAddress.value;
          if(address.id.isEmpty){
            return Center(
              child: Text('Select Address'),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address.name, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(width: USizes.spaceBtwItems / 2),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: USizes.iconSm,
                    color: UColors.darkGrey,
                  ),
                  SizedBox(width: USizes.spaceBtwItems),
                  Text(address.phoneNumber),
                ],
              ),
              SizedBox(width: USizes.spaceBtwItems / 2),
              Row(
                children: [
                  Icon(
                    Icons.location_history,
                    size: USizes.iconSm,
                    color: UColors.darkGrey,
                  ),
                  SizedBox(width: USizes.spaceBtwItems),
                  Expanded(
                    child: Text(
                      address.toString(),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }
}

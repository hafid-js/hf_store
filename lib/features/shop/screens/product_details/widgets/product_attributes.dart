import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/widgets/chips/choice_chip.dart';
import 'package:hf_shop/common/widgets/custom_shapes/rounded_container.dart';
import 'package:hf_shop/common/widgets/texts/product_price_text.dart';
import 'package:hf_shop/common/widgets/texts/product_title_text.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/shop/controllers/product/variation_controller.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/constants/texts.dart';

class UProductAttributes extends StatelessWidget {
  const UProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(() => Column(
      children: [
        if(controller.selectedVariation.value.id.isNotEmpty)
        URoundedContainer(
          padding: EdgeInsets.all(USizes.sm),
          backgroundColor: dark ? UColors.darkGrey : UColors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      USectionHeading(
                        title: 'Variation',
                        showActionButton: false,
                      ),
                      SizedBox(width: USizes.spaceBtwItems),

                      Column(
                        children: [
                          Row(
                            children: [
                              UProductTitleText(
                                title: 'Price : ',
                                smallSize: true,
                              ),
                              if(controller.selectedVariation.value.salePrice > 0)
                              Text(
                                '${UTexts.currency}${controller.selectedVariation.value.price.toStringAsFixed(0)}',
                                style: Theme.of(context).textTheme.titleSmall!
                                    .apply(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                              SizedBox(width: USizes.spaceBtwItems),
                              UProductPriceText(price: controller.getVariationPrice()),
                            ],
                          ),

                          Row(
                            children: [
                              UProductTitleText(
                                title: 'Stock : ',
                                smallSize: true,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              UProductTitleText(
                title: controller.selectedVariation.value.description ?? '',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),

        SizedBox(height: USizes.spaceBtwItems),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: product.productAttributes!.map((attribute) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                USectionHeading(
                  title: attribute.name ?? '',
                  showActionButton: false,
                ),
                SizedBox(height: USizes.spaceBtwItems / 2),
                Obx(() => Wrap(
                  spacing: USizes.sm,
                  children: attribute.values!.map((attributeValue) {
                    bool isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                    bool available = controller.getAttributesAvailabilityVariation(product.productVariations!, attribute.name!).contains(attributeValue);
                    return UChoiceChip(
                      text: attributeValue,
                      selected: isSelected,
                      onSelected: available ? (selected) {
                        if(available && selected) {
                          controller.onAttributeSelected(product, attribute.name, attributeValue);
                        }
                      } : null,
                    ) ;
                  }).toList(),
                )),
              ],
            );
          }).toList(),
        ),
      ],
    ),);
  }
}

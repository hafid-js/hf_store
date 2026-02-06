import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/widgets/custom_shapes/rounded_container.dart';
import 'package:hf_shop/features/shop/controllers/promo_code/promo_code_controller.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UPromoCodeField extends StatelessWidget {
  const UPromoCodeField({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(PromoCodeController());
    return URoundedContainer(
      showBorder: true,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.only(
        left: USizes.md,
        top: USizes.sm,
        right: USizes.sm,
        bottom: USizes.sm,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              onChanged: controller.onPromoChanged,
              decoration: InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 80.0,
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.appliedPromoCode.value.id.isNotEmpty
                    ? null
                    : controller.promoCode.isEmpty
                    ? null
                    : controller.applyPromoCode,
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
                ),
                child: controller.isLoading.value
                    ? SizedBox(
                        width: USizes.lg,
                        height: USizes.lg,
                        child: CircularProgressIndicator(color: UColors.white),
                      )
                    : Text(
                        controller.appliedPromoCode.value.id.isEmpty
                            ? 'Apply'
                            : 'Applied',
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

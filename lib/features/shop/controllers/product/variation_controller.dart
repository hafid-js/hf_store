import 'package:get/get.dart';
import 'package:hf_shop/features/shop/controllers/product/image_controller.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/features/shop/models/product_variation_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  RxMap selectedAttributes = {}.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;
  RxString variationStockStatus = ''.obs;

  void onAttributeSelected(
    ProductModel product,
    attributeName,
    attributeValue,
  ) {
    Map<String, dynamic> selectedAttributes = Map<String, dynamic>.from(
      this.selectedAttributes,
    );
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    ProductVariationModel selectedVariation = product.productVariations!
        .firstWhere(
          (variation) => isSameAttributeValues(
            variation.attributeValues,
            selectedAttributes,
          ),
          orElse: () => ProductVariationModel.empty(),
        );

    if (selectedVariation.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    this.selectedVariation(selectedVariation);
    getProductVariationStockStatus();
  }

  bool isSameAttributeValues(
    Map<String, dynamic> variationAttributes,
    Map<String, dynamic> selectedAttributes,
  ) {
    if (variationAttributes.length != selectedAttributes.length) {
      return false;
    }

    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) {
        return false;
      }
    }
    return true;
  }

  List<String?> getAttributesAvailabilityVariation(
    List<ProductVariationModel> variations,
    String attributeName,
  ) {
    final availableAttributesValues = variations
        .where(
          (variation) =>
              variation.attributeValues[attributeName]!.isNotEmpty &&
              variation.attributeValues[attributeName] != null &&
              variation.stock > 0,
        )
        .map((variation) => variation.attributeValues[attributeName])
        .toSet()
        .toList();

    return availableAttributesValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toStringAsFixed(0);
  }

  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0
        ? 'In Stock'
        : 'Out of Stock';
  }
}

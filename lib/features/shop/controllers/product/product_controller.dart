import 'package:get/get.dart';
import 'package:hf_shop/data/repositories/product/product_repository.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final _repository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxBool isLoading = false.obs;

@override
  void onInit() {
    getFeaturedProduct();
    super.onInit();
  }

  Future<void> getFeaturedProduct() async {
    try {
      
      isLoading.value = true;
      List<ProductModel> featuredProducts = await _repository.fetchFeaturedProducts();
      this.featuredProducts.assignAll(featuredProducts);
         
    } catch (e) {
         isLoading.value = false;
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
        isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getAllFeaturedProduct() async {
    try {
    
      List<ProductModel> featuredProducts = await _repository.fetchAllFeaturedProducts();
      return featuredProducts;
         
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }
  }
  


  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if(salePrice == null || salePrice <= 0.0) return null;
    if(originalPrice <= 0.0) return null;

    double percentage = ((originalPrice - salePrice / originalPrice) * 100);

    return percentage.toStringAsFixed(1);
  }

}
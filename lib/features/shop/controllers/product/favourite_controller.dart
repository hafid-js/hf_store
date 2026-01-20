import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hf_shop/data/repositories/authentication_repository.dart';
import 'package:hf_shop/data/repositories/product/product_repository.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class FavouriteController extends GetxController {
  static FavouriteController instance = Get.find();


  RxMap<String, bool> favourites = <String, bool>{}.obs;
  final _storage = GetStorage(AuthenticationRepository.instance.currentUser!.uid);

  @override
  void onInit() {
    initFavourites();
    super.onInit();
  }

 Future<void> initFavourites() async {
  final encoded = _storage.read<String>('favourites');

  if (encoded == null || encoded.isEmpty) return;

  final decoded = jsonDecode(encoded) as Map<String, dynamic>;

  favourites.assignAll(
    decoded.map((key, value) => MapEntry(key, value == true)),
  );
}



  void toggleFavouriteProduct(String productId) {
    if(favourites.containsKey(productId)) {
      favourites.remove(productId);
        saveFavouritesToStorage();
        USnackBarHelpers.customToast(message: 'Product has been removed from WIshlist');
        
    } else {
      favourites[productId] = true;
      saveFavouritesToStorage();
      USnackBarHelpers.customToast(message: 'Product has been added to the Wishlist');
    }
  }

  void saveFavouritesToStorage() {
    String encodeFavourites = jsonEncode(favourites);
    _storage.write('favourites', encodeFavourites);
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }


  Future<List<ProductModel>> getFavouritesProducts() async {
    final productsIds = favourites.keys.toList();
    return await ProductRepository.instance.getFavouritesProducts(productsIds);
  }
}
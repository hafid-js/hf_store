import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hf_shop/data/services/cloudinary_services.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/keys.dart';
import 'package:hf_shop/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:hf_shop/utils/exceptions/firebase_exceptions.dart';
import 'package:hf_shop/utils/exceptions/format_exceptions.dart';
import 'package:hf_shop/utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  Future<void> uploadProducts(List<ProductModel> products) async {
    try {
      for (final original in products) {
        final product = ProductModel.fromJson(original.toJson());

        if (product.thumbnail.startsWith('assets/')) {
          final file = await UHelperFunctions.assetToFile(product.thumbnail);
          final dio.Response res = await _cloudinaryServices.uploadImage(
            file,
            UKeys.productsFolder,
          );

          if (res.statusCode == 200) {
            product.thumbnail = res.data['url'];
          }
        }

        if (product.images != null && product.images!.isNotEmpty) {
          final uploadedImages = <String>[];

          for (final img in product.images!) {
            if (!img.startsWith('assets/')) {
              uploadedImages.add(img);
              continue;
            }

            final file = await UHelperFunctions.assetToFile(img);
            final dio.Response res = await _cloudinaryServices.uploadImage(
              file,
              UKeys.productsFolder,
            );

            if (res.statusCode == 200) {
              uploadedImages.add(res.data['url']);
            }
          }

          product.images = uploadedImages;
        } else {
          product.images = [];
        }

        if (product.brand != null &&
            product.brand!.image.startsWith('assets/')) {
          File brandFile = await UHelperFunctions.assetToFile(
            product.brand!.image,
          );
          dio.Response brandRes = await _cloudinaryServices.uploadImage(
            brandFile,
            UKeys.brandsFolder,
          );
          if (brandRes.statusCode == 200 && brandRes.data['url'] != null) {
            product.brand!.image = brandRes.data['url'];
          }
        }

        if (product.productVariations != null &&
            product.productVariations!.isNotEmpty) {
          for (final v in product.productVariations!) {
            if (v.image != null && v.image!.startsWith('assets/')) {
              final file = await UHelperFunctions.assetToFile(v.image!);
              final dio.Response res = await _cloudinaryServices.uploadImage(
                file,
                UKeys.productsFolder,
              );

              if (res.statusCode == 200) {
                v.image = res.data['url'];
              }
            }
          }
        }

        await _db
            .collection(UKeys.productsCollection)
            .doc(original.id)
            .set(product.toJson());

        print('Product ${product.id} uploaded');
      }
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong ${e.toString()}';
    }
  }

  Future<List<ProductModel>> fetchFeaturedProducts() async {
    try {
      final query = await _db
          .collection(UKeys.productsCollection)
          .where('isFeatured', isEqualTo: true)
          .limit(4)
          .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong ${e.toString()}. Please try again!';
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final query = await _db
          .collection(UKeys.productsCollection)
          .where('isFeatured', isEqualTo: true)
          .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong ${e.toString()}. Please try again!';
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final query = await _db
          .collection(UKeys.productsCollection)
          .where('isFeatured', isEqualTo: true)
          .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong ${e.toString()}. Please try again!';
    }
  }

  Future<List<ProductModel>> getProductsForBrand({
    required String brandId,
    int limit = -1,
  }) async {
    try {
      final query = limit == -1
          ? await _db
                .collection(UKeys.productsCollection)
                .where('brand.id', isEqualTo: brandId)
                .get()
          : await _db
                .collection(UKeys.productsCollection)
                .where('brand.id', isEqualTo: brandId)
                .limit(limit)
                .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong ${e.toString()}. Please try again!';
    }
  }

  Future<List<ProductModel>> getProductsForCategory({
    required String categoryId,
    int limit = -4,
  }) async {
    try {
      final productCategoryQuery = limit == -1
          ? await _db
                .collection(UKeys.productCategoryCollection)
                .where('categoryId', isEqualTo: categoryId)
                .get()
          : await _db
                .collection(UKeys.productCategoryCollection)
                .where('categoryId', isEqualTo: categoryId)
                .limit(limit)
                .get();

      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      final productQuery = await _db
          .collection(UKeys.productsCollection)
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      List<ProductModel> products = productQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

          return products;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong ${e.toString()}. Please try again!';
    }
  }
}

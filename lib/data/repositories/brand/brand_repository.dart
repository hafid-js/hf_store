import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hf_shop/data/services/cloudinary_services.dart';
import 'package:hf_shop/features/shop/models/brand_category.dart';
import 'package:hf_shop/features/shop/models/brand_model.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/keys.dart';
import 'package:hf_shop/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:hf_shop/utils/exceptions/firebase_exceptions.dart';
import 'package:hf_shop/utils/exceptions/format_exceptions.dart';
import 'package:hf_shop/utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  Future<void> uploadBrands(List<BrandModel> brands) async {
    try {
      for (final original in brands) {
        final brand = BrandModel.fromJson(original.toJson());

        if (brand.image.startsWith('assets/')) {
          final file = await UHelperFunctions.assetToFile(brand.image);

          final dio.Response res = await _cloudinaryServices.uploadImage(
            file,
            UKeys.brandsFolder,
          );

          if (res.statusCode == 200) {
            brand.image = res.data['url'];
          }
        }
        await _db
            .collection(UKeys.brandsCollection)
            .doc(brand.id)
            .set(brand.toJson());

        print('Brand ${brand.name} uploaded');
      }
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again! ${e.toString()}';
    }
  }

  Future<List<BrandModel>> fetchBrands() async {
    try {
      final query = await _db.collection(UKeys.brandsCollection).get();
      if (query.docs.isNotEmpty) {
        List<BrandModel> brands = query.docs
            .map((document) => BrandModel.fromSnapshot(document))
            .toList();
        return brands;
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
      throw 'Something went wrong. Please try again! ${e.toString()}';
    }
  }

  Future<List<BrandModel>> fetchBrandsForCategory(String categoryId) async {
    try {
      final brandCategoryQuery = await _db
          .collection(UKeys.brandCategoryCollection)
          .where('categoryId', isEqualTo: categoryId)
          .get();

      List<BrandCategoryModel> brandCategories = brandCategoryQuery.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();

      List<String> brandIds = brandCategories
          .map((brandCategory) => brandCategory.brandId)
          .toList();

      final brandsQuery = await _db
          .collection(UKeys.brandsCollection)
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();
          
      List<BrandModel> brands = brandsQuery.docs
          .map((doc) => BrandModel.fromSnapshot(doc))
          .toList();

      return brands;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again! ${e.toString()}';
    }
  }
}

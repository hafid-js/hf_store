import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hf_shop/data/services/cloudinary_services.dart';
import 'package:hf_shop/features/shop/models/category_model.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/keys.dart';
import 'package:hf_shop/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:hf_shop/utils/exceptions/firebase_exceptions.dart';
import 'package:hf_shop/utils/exceptions/format_exceptions.dart';
import 'package:hf_shop/utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  Future<void> uploadCategories(List<CategoryModel> categories) async {
    try {
      for(final category in categories) {

        File image = await UHelperFunctions.assetToFile(category.image);
        dio.Response response = await _cloudinaryServices.uploadImage(image, UKeys.categoryFolder);
        if(response.statusCode == 200) {
          category.image = response.data['url'];
        }

       await _db.collection(UKeys.categoryCollection).doc(category.id).set(category.toJson());

       print('Category Uploaded: ${category.name}');
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
      throw 'Something went wrong. Please try again!';
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final query = await _db.collection(UKeys.categoryCollection).get();

      if(query.docs.isNotEmpty) {
        List<CategoryModel> categories = query.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
        return categories;
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
      throw 'Something went wrong. Please try again!';
    }
  }
}

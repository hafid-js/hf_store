import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hf_shop/data/services/cloudinary_services.dart';
import 'package:hf_shop/features/shop/models/banners_model.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';
import 'package:hf_shop/utils/constants/keys.dart';
import 'package:hf_shop/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:hf_shop/utils/exceptions/firebase_exceptions.dart';
import 'package:hf_shop/utils/exceptions/format_exceptions.dart';
import 'package:hf_shop/utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();


  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  Future<void> uploadBanners(List<BannerModel> banners) async {
    try {

    for(final banner in banners) {

      File image = await UHelperFunctions.assetToFile(banner.imageUrl);
      dio.Response response = await _cloudinaryServices.uploadImage(image, UKeys.bannerFolder);
      if(response.statusCode == 200) {
        banner.imageUrl = response.data['url'];
      }
       await _db.collection(UKeys.bannerCollection).doc().set(banner.toJson());

       print('Banner Uploaded : ${banner.targetScreen}');
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


  Future<List<BannerModel>> fetchActiveBanners() async {
    try {

      final query = await _db.collection(UKeys.bannerCollection).where('active', isEqualTo: true).get();
      if(query.docs.isNotEmpty) {
        List<BannerModel> banners = query.docs.map((document) => BannerModel.fromDocument(document)).toList();
        return banners;
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
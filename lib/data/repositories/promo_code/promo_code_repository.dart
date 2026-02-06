import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hf_shop/features/shop/models/promo_code.dart';
import 'package:hf_shop/utils/constants/keys.dart';
import 'package:hf_shop/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:hf_shop/utils/exceptions/firebase_exceptions.dart';
import 'package:hf_shop/utils/exceptions/format_exceptions.dart';
import 'package:hf_shop/utils/exceptions/platform_exceptions.dart';

class PromoCodeRepository extends GetxController {
  static PromoCodeRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> uploadPromoCodes(List<PromoCodeModel> promoCodes) async {
    try {
      for (final promoCode in promoCodes) {
        _db
            .collection(UKeys.promoCodesCollection)
            .doc(promoCode.id)
            .set(promoCode.toJson());
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

  Future<PromoCodeModel> fetchSinglePromoCode(String code) async {
    try {
      final query = await _db
          .collection(UKeys.promoCodesCollection)
          .where('code', isEqualTo: code)
          .get();
      if (query.docs.isNotEmpty) {
        PromoCodeModel promoCode = PromoCodeModel.fromSnapshot(
          query.docs.first,
        );
        return promoCode;
      }

      return PromoCodeModel.empty();
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

  Future<void> updateSingleField(PromoCodeModel promoCode, String key, dynamic value) async {
    try {

      await _db.collection(UKeys.promoCodesCollection).doc(promoCode.id).update({key : value});

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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hf_shop/data/repositories/authentication_repository.dart';
import 'package:hf_shop/features/personalization/models/address_model.dart';
import 'package:hf_shop/utils/constants/keys.dart';
import 'package:hf_shop/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:hf_shop/utils/exceptions/firebase_exceptions.dart';
import 'package:hf_shop/utils/exceptions/format_exceptions.dart';
import 'package:hf_shop/utils/exceptions/platform_exceptions.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<String> addAddress(AddressModel address) async {
    try {

      final userId = AuthenticationRepository.instance.currentUser!.uid;
      final currentAddress =  await _db.collection(UKeys.userCollection).doc(userId).collection(UKeys.addressCollection).add(address.toJson());
      return currentAddress.id;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while Address Information. Please try again!';
    }
  }

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {

      final userId = AuthenticationRepository.instance.currentUser!.uid;
      if(userId.isEmpty){
        throw 'User not found, Please login again!';
      }

     final query = await _db.collection(UKeys.userCollection).doc(userId).collection(UKeys.addressCollection).get();
     if(query.docs.isNotEmpty) {
      List<AddressModel> addresses = query.docs.map((doc) => AddressModel.fromDocumentSnapshot(doc)).toList();
      return addresses;
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
      throw 'Unable to find addresses. Please try again!';
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.currentUser!.uid;
      await _db.collection(UKeys.userCollection).doc(userId).collection(UKeys.addressCollection).doc(addressId).update({
        'selectedAddress': selected,
      });
    } catch (e) {
      throw 'Unable to update selected address. Please try again!';
    }
  }

}
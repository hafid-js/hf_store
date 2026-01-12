import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hf_shop/utils/constants/apis.dart';
import 'package:hf_shop/utils/constants/keys.dart';

class CloudinaryServices extends GetxController {
  static CloudinaryServices get instance => Get.find();

  final _dio = dio.Dio();

  Future<dio.Response> uploadImage(File image, String folderName) async {
    try {
      String api = UApiUrls.uploadApi(UKeys.cloudName);
      dio.FormData formData = dio.FormData.fromMap({
        'upload_preset': UKeys.uploadPreset,
        'folder': UKeys.profileFolder,
        'file': await dio.MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      final dioClient = dio.Dio();
      final response = await dioClient.post(api, data: formData);
      return response;
    } on dio.DioException catch (e) {
      throw e.response?.data ?? 'Image upload failed';
    } catch (e) {
      throw 'Failed to upload profile picture. Please try again';
    }
  }


    Future<dio.Response> deleteImage(String publicId) async {
    try {
      String api = UApiUrls.deleteApi(UKeys.cloudName);

      int timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();

      String signatureBase = 'public_id=$publicId&timestamp=$timestamp${UKeys.apiSecret}';
      String signature = sha1.convert(utf8.encode(signatureBase)).toString();

      final formData = dio.FormData.fromMap({
        'public_id' : publicId,
        'api_key' : UKeys.apiKey,
        'timestamp' : timestamp,
        'signature' : signature
      });
      final response = await _dio.post(api, data: formData);
      return response;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  
}
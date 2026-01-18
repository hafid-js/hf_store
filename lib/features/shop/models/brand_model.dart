import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
  });

  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'productCount': productsCount,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> data) {
  if (data.isEmpty) return BrandModel.empty();

  return BrandModel(
    id: data['id'] ?? '',
    name: data['name'] ?? '',
    image: data['image'] ?? '',
    isFeatured: data['isFeatured'],
    productsCount: data['productCount'],
  );
}


  factory BrandModel.fromSnapshot(
  DocumentSnapshot<Map<String, dynamic>> document,
) {
  final data = document.data();
  if (data == null) return BrandModel.empty();

  return BrandModel(
    id: data['id'] ?? document.id,
    name: data['name'] ?? '',
    image: data['image'] ?? '',
    isFeatured: data['isFeatured'],
    productsCount: data['productCount'],
  );
}

}

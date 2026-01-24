import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hf_shop/features/shop/models/brand_model.dart';
import 'package:hf_shop/features/shop/models/product_attribute_model.dart';
import 'package:hf_shop/features/shop/models/product_variation_model.dart';

class ProductModel {
  String id;
  String title;
  DateTime? date;
  int stock;
  double price;
  double? salePrice;
  String thumbnail;
  List<String>? images;
  String description;
  BrandModel? brand;
  String sku;
  String categoryId;
  bool isFeatured;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    this.salePrice,
    required this.thumbnail,
    this.images,
    required this.description,
    this.brand,
    this.date,
    required this.sku,
    required this.categoryId,
    this.isFeatured = false,
    required this.productType,
    this.productAttributes,
    this.productVariations,
  });

  static ProductModel empty() => ProductModel(
    id: '',
    title: '',
    stock: 0,
    price: 0,
    thumbnail: '',
    description: '',
    sku: '',
    categoryId: '',
    productType: 'ProductType.single',
  );

  Map<String, dynamic> toJson() {
    return {
      'sku': sku,
      'title': title,
      'stock': stock,
      'price': price,
      'images': images ?? [],
      'thumbnail': thumbnail,
      'salePrice': salePrice,
      'isFeatured': isFeatured,
      'categoryId': categoryId,
      'brand': brand!.toJson(),
      'description': description,
      'productType': productType,
      'productAttributes':
          productAttributes?.map((e) => e.toJson()).toList() ?? [],
      'productVariations':
          productVariations?.map((e) => e.toJson()).toList() ?? [],
   'date': FieldValue.serverTimestamp(),
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      stock: json['stock'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      salePrice: json['salePrice']?.toDouble(),
      thumbnail: json['thumbnail'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      description: json['description'] ?? '',
      brand: json['brand'] != null ? BrandModel.fromJson(json['brand']) : null,
      sku: json['sku'] ?? '',
      categoryId: json['categoryId'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      productType: json['productType'] ?? 'ProductType.single',
      productAttributes: json['productAttributes'] != null
          ? (json['productAttributes'] as List)
                .map((e) => ProductAttributeModel.fromJson(e))
                .toList()
          : [],
      productVariations: json['productVariations'] != null
          ? (json['productVariations'] as List)
                .map((e) => ProductVariationModel.fromJson(e))
                .toList()
          : [],
     date: json['date'] is Timestamp
    ? (json['date'] as Timestamp).toDate()
    : null,
    );
  }

  factory ProductModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snap,
  ) {
    final json = snap.data()!;
    return ProductModel(
      id: snap.id,
      title: json['title'] ?? '',
      stock: json['stock'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      salePrice: json['salePrice']?.toDouble(),
      thumbnail: json['thumbnail'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      description: json['description'] ?? '',
      brand: json['brand'] != null ? BrandModel.fromJson(json['brand']) : null,
      sku: json['sku'] ?? '',
      categoryId: json['categoryId'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      productType: json['productType'] ?? 'ProductType.single',
      productAttributes: json['productAttributes'] != null
          ? (json['productAttributes'] as List)
                .map((e) => ProductAttributeModel.fromJson(e))
                .toList()
          : [],
      productVariations: json['productVariations'] != null
          ? (json['productVariations'] as List)
                .map((e) => ProductVariationModel.fromJson(e))
                .toList()
          : [],
date: json['date'] is Timestamp
    ? (json['date'] as Timestamp).toDate()
    : null,
    );
  }

  factory ProductModel.fromQuerySnapshot(
    QueryDocumentSnapshot<Object?> document,
  ) {
    final data = document.data()! as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      title: data['title'] ?? '',
      stock: data['stock'] ?? 0,
      price: double.parse((data['price'] ?? 0.0).toString()),
      salePrice: data['salePrice'] != null
          ? double.parse(data['salePrice'].toString())
          : null,
      thumbnail: data['thumbnail'] ?? '',
      productType: data['productType'] ?? '',
      sku: data['sku'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      brand: data['brand'] != null ? BrandModel.fromJson(data['brand']) : null,
      description: data['description'] ?? '',
      categoryId: data['categoryId'] ?? '',
      images: data['images'] != null ? List<String>.from(data['images']) : [],
      productAttributes: data['productAttributes'] != null
          ? (data['productAttributes'] as List)
                .map((e) => ProductAttributeModel.fromJson(e))
                .toList()
          : [],
      productVariations: data['productVariations'] != null
          ? (data['productVariations'] as List)
                .map((e) => ProductVariationModel.fromJson(e))
                .toList()
          : [],
      date: data['date'] is Timestamp
    ? (data['date'] as Timestamp).toDate()
    : null,

    );
  }
}

extension ProductModelHelpers on ProductModel {

  ProductVariationModel? getVariationSafe(int index) {
    if (productVariations != null &&
        productVariations!.isNotEmpty &&
        index >= 0 &&
        index < productVariations!.length) {
      return productVariations![index];
    }
    return null; // fallback kalau index tidak valid
  }


  double getEffectivePrice({int? variationIndex}) {
    final variation = variationIndex != null
        ? getVariationSafe(variationIndex)
        : null;
    if (variation != null) {
      return variation.salePrice ?? variation.price;
    }
    return salePrice ?? price;
  }


  int getEffectiveStock({int? variationIndex}) {
    final variation = variationIndex != null
        ? getVariationSafe(variationIndex)
        : null;
    if (variation != null) {
      return variation.stock;
    }
    return stock;
  }

}

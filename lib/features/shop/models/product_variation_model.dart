class ProductVariationModel {
  String id;
  Map<String, String> attributeValues;
  double price;
  int stock;
  double? salePrice;
  String? image;
  String? description;
  String? sku;

  ProductVariationModel({
    required this.id,
    required this.attributeValues,
    required this.price,
    required this.stock,
    this.salePrice,
    this.image,
    this.description,
    this.sku,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributeValues': attributeValues,
      'price': price,
      'stock': stock,
      'image': image,
      'description': description,
      'sku': sku,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    return ProductVariationModel(
      id: json['id'] ?? '',
      attributeValues:
          Map<String, String>.from(json['attributeValues'] ?? {}),
      price: (json['price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      salePrice: json['salePrice']?.toDouble(),
      image: json['image'],
      description: json['description'],
      sku: json['sku'],
    );
  }
}

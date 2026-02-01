class CartItemModel {
  String productId;
  String title;
  double price;
  int quantity;
  String variationId;
  String? image;
  String? brandName;
  Map<String, dynamic>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.brandName,
    this.selectedVariation,
  });

  /// Empty Cart
  static CartItemModel empty() =>
      CartItemModel(productId: '', title: '', price: 0.0, quantity: 0);

  Map<String, dynamic> toJson() {
  return {
    'productId': productId,
    'title': title,
    'price': price.toDouble(),
    'image': image ?? '',
    'quantity': quantity,
    'variationId': variationId,
    'brandName': brandName ?? '',
    'selectedVariation': selectedVariation != null
        ? selectedVariation!.map((k, v) => MapEntry(k, v ?? ''))
        : {},
  };
}


  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] ?? '',
      title: json['title'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'],
      quantity: json['quantity'] ?? 0,
      variationId: json['variationId'] ?? '',
      brandName: json['brandName'],
      selectedVariation: json['selectedVariation'] != null
          ? Map<String, dynamic>.from(json['selectedVariation'])
          : null,
    );
  }
}

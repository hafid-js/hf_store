class ProductAttributeModel {
  String name;
  List<String> values;

  ProductAttributeModel({
    required this.name,
    required this.values,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'values': values,
    };
  }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) {
    return ProductAttributeModel(
      name: json['name'] ?? '',
      values: json['values'] != null
          ? List<String>.from(json['values'])
          : [],
    );
  }
}

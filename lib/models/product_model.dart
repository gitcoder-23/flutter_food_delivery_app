class ProductModel {
  int? id;
  String? productId;
  String? productImage;
  String? productName;
  int? productPrice;
  int? productQuantity;
  // Array? productUnit;
  List<dynamic>? productUnit;

  ProductModel({
    this.id,
    this.productId,
    this.productImage,
    this.productName,
    this.productPrice,
    this.productQuantity,
    this.productUnit,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    productUnit = json['productUnit'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productUnit'] = productUnit;
    return data;
  }

  // map(Column Function(dynamic data) param0) {}
}

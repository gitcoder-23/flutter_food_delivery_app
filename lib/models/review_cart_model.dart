class ReviewCartModel {
  String cartId;
  String cartName;
  String cartImage;
  int cartPrice;
  int cartQuantity;
  bool? isAdd;
  var cartUnit;

  ReviewCartModel({
    required this.cartId,
    required this.cartName,
    required this.cartImage,
    required this.cartPrice,
    required this.cartQuantity,
    this.cartUnit,
    this.isAdd,
  });
}

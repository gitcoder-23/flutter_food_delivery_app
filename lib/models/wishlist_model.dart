class WishListModel {
  bool? wishList;
  String wishListId;
  String wishListImage;
  String wishListName;
  int wishListPrice;
  int? wishListQuantity;

  WishListModel({
    this.wishList,
    required this.wishListId,
    required this.wishListImage,
    required this.wishListName,
    required this.wishListPrice,
    this.wishListQuantity,
  });
}

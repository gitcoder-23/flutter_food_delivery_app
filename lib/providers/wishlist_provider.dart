import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/models/wishlist_model.dart';

class WishListProvider with ChangeNotifier {
  // Add Cart data to firebase Store
  void addWishListData({
    String? wishListId,
    String? wishListName,
    String? wishListImage,
    int? wishListPrice,
    int? wishListQuantity,
    // bool? isAdd,
  }) async {
    // "WishList"--> Collection Name
    // "YourWishList"--> Sub-Collection Name
    // print('@@@@WishList-state-count->> $wishListQuantity');
    await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourWishList')
        .doc(wishListId)
        .set(
      {
        "wishListId": wishListId,
        "wishListName": wishListName,
        "wishListImage": wishListImage,
        "wishListPrice": wishListPrice,
        "wishListQuantity": wishListQuantity,
        // "wishList": wishList,
        // If data added then true
        "wishList": true,
      },
    );
  }

  ///// Get WishList Data ///////
  List<WishListModel> wishListProduct = [];

  fetchWishtListData() async {
    List<WishListModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .get();
    for (var element in value.docs) {
      WishListModel wishListModel = WishListModel(
        wishListId: element.get("wishListId"),
        wishListImage: element.get("wishListImage"),
        wishListName: element.get("wishListName"),
        wishListPrice: element.get("wishListPrice"),
        wishListQuantity: element.get("wishListQuantity"),
      );
      newList.add(wishListModel);
    }
    wishListProduct = newList;
    notifyListeners();
  }

  List<WishListModel> get getWishList {
    return wishListProduct;
  }

////////// Delete WishList /////
  deleteWishtList(String wishListId) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .delete();
  }
}

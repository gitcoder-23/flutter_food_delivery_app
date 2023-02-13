// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/models/review_cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  List<ReviewCartModel> reviewCartDataList = [];

  // Add Cart data to firebase Store
  void addReviewCartData({
    String? cartId,
    String? cartName,
    String? cartImage,
    int? cartPrice,
    int? cartQuantity,
    var cartUnit,
    // bool? isAdd,
  }) async {
    // "ReviewCart"--> Collection Name
    // "YourReviewCart"--> Sub-Collection Name
    // print('@@@@ReviewCart-state-count->> $cartQuantity');
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviewCart')
        .doc(cartId)
        .set(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "cartUnit": cartUnit,
        // "isAdd": isAdd,
        // If data added then true
        "isAdd": true,
      },
    );
  }

  // Update Cart data to firebase Store
  void updateReviewCartData({
    String? cartId,
    String? cartName,
    String? cartImage,
    int? cartPrice,
    int? cartQuantity,
    // var cartUnit,
    // bool? isAdd,
  }) async {
    // "ReviewCart"--> Collection Name
    // "YourReviewCart"--> Sub-Collection Name
    // print('@@@@ReviewCart-state-count->> $cartQuantity');
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviewCart')
        .doc(cartId)
        .update(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        // "cartUnit": cartUnit,
        // "isAdd": isAdd,
        // If data added then true
        "isAdd": true,
      },
    );
  }

  // Get Cart Data From Firebase /////////////

  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];

    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviewCart')
        .get();
    // if want to get single data use Where loop
    reviewCartValue.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
        cartId: element.get('cartId'),
        cartName: element.get('cartName'),
        cartImage: element.get('cartImage'),
        cartPrice: element.get('cartPrice'),
        cartQuantity: element.get('cartQuantity'),
        cartUnit: element.get('cartUnit'),
      );
      newList.add(reviewCartModel);
    });

    reviewCartDataList = newList;
    notifyListeners();

    // for (var element in reviewCartValue.docs) {
    //   ReviewCartModel reviewCartModel = ReviewCartModel(cartId: cartId, cartName: cartName, cartImage: cartImage, cartPrice: cartPrice, cartQuantity: cartQuantity)
    // }
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }
  ////////Get Cart Data From Firebase End ///////////

  ///////// Delete Reciew Cart Data //////////

  void deleteReviewCartData(String cartId) async {
    // print('Review-State--> $cartId');
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviewCart')
        .doc(cartId)
        .delete();
    notifyListeners();
  }

  void deleteAllReviewCartData() async {
    var collection = FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();

    print("deleteAllReviewCartData ---> $collection");
    // print('collection@@@@-> $collection');
    // var snapshots = await collection.get();
    // for (var doc in snapshots.docs) {
    //   print('collection@@@@-> $doc');

    //   await doc.reference.delete();
    // }
    notifyListeners();
  }

  /// Delete Operation End/////////

  /// //////Total Price //////////

  getTotalPriceInCart() {
    double total = 0.0;
    reviewCartDataList.forEach((element) {
      // print('@@@review-cart-state:  ${element.cartQuantity}');
      total += (element.cartPrice * element.cartQuantity);
      // print('@@State-total:  $total');
    });
    return total;
  }
}

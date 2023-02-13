// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class Count extends StatefulWidget {
  int? id;
  String productName;
  String productImage;
  String productId;
  int productPrice;
  late String? productUnit;

  Count(
      {this.id,
      required this.productName,
      required this.productImage,
      required this.productId,
      required this.productPrice,
      this.productUnit,
      super.key});

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  // int count = 0;
  int count = 1;
  String cartUnitValue = '';

  bool isTrue = false;

  @override
  void initState() {
    getAddedReviewItems();
    getAllReviewCarts();
    super.initState();
  }

  getAllReviewCarts() async {
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context, listen: false);

    if (mounted) {
      reviewCartProvider.getReviewCartData();
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      getAllReviewCarts();
    }
  }

  // getAddAndQuantity() {
  //   FirebaseFirestore.instance
  //       .collection('ReviewCart')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('YourReviewCart')
  //       .get()
  //       .then((value) => {
  //             if (mounted)
  //               {
  //                 value.docs.forEach((element) {
  //                   // print('getAddAndQuantity--> ${element.data()}');
  //                   setState(() {
  //                     // isAdd -- boolean
  //                     isTrue = element.get('isAdd');
  //                   });
  //                 })
  //               }
  //           });
  // }

  getAddedReviewItems() {
    FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviewCart')
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (mounted)
                {
                  if (value.exists)
                    {
                      print('getAddAndQuantity:-> $value'),
                      setState(() {
                        // update count
                        count = value.get("cartQuantity");
                        cartUnitValue = value.get("cartUnit");
                        // isAdd -- boolean
                        isTrue = value.get('isAdd');
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    // print('@@Count-productUnit--> $cartUnitValue  &&& ${widget.productUnit}');

    // getAddAndQuantity();

    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);

    // return Expanded(
    return Container(
      height: 30,
      width: 70,
      // color: Colors.red,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isTrue == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    if (count == 1) {
                      setState(() {
                        isTrue = false;
                      });
                      reviewCartProvider.deleteReviewCartData(widget.productId);
                    } else if (count > 1) {
                      setState(() {
                        count = count - 1;
                      });

                      reviewCartProvider.updateReviewCartData(
                        cartId: widget.productId,
                        cartName: widget.productName,
                        cartImage: widget.productImage,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.remove,
                    size: 15,
                    color: Color(0xffd0b84c),
                  ),
                ),
                Text(
                  '$count',
                  style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(251, 223, 105, 9),
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    if (count == 6) {
                      setState(() {
                        count = 6;
                      });
                    } else {
                      setState(() {
                        count = count + 1;
                      });
                      reviewCartProvider.updateReviewCartData(
                        cartId: widget.productId,
                        cartName: widget.productName,
                        cartImage: widget.productImage,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.add,
                    size: 15,
                    color: Color(0xffd0b84c),
                  ),
                ),
              ],
            )
          : Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isTrue = true;
                  });
                  // Add to firebase Cart Value
                  reviewCartProvider.addReviewCartData(
                    cartId: widget.productId,
                    cartName: widget.productName,
                    cartImage: widget.productImage,
                    cartPrice: widget.productPrice,
                    cartQuantity: count,
                    cartUnit: widget.productUnit,
                    // If data added then true
                    // isAdd: true,
                  );
                },
                child: Text(
                  'Add',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
    );
    // );
  }
}

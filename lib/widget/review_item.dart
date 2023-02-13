import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/models/review_cart_model.dart';
import 'package:flutter_food_delivery_app/providers/review_cart_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ReviewItem extends StatefulWidget {
  final Function onTapDelete;
  final String cartId;
  final String cartName;
  final String cartImage;
  final int cartPrice;
  final int cartQuantity;
  final ReviewCartModel? cartData;
  final dynamic? context;
  var cartUnit;
  ReviewItem({
    required this.onTapDelete,
    required this.cartId,
    required this.cartName,
    required this.cartImage,
    required this.cartPrice,
    required this.cartQuantity,
    this.cartData,
    this.context,
    this.cartUnit,
    super.key,
  });

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  late int count;
  @override
  void initState() {
    getCount();
    getAllReviewCarts();
    super.initState();
  }

  getCount() {
    setState(() {
      count = widget.cartQuantity;
    });
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: buildSearchedItemList(count),
        ),
        const Divider(height: 1, color: Colors.black45)
      ],
    );
  }

  Widget buildSearchedItemList(count) {
    getCount();
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);

    reviewCartProvider.getReviewCartData();
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Center(child: Image.network(widget.cartImage)),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartName,
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '\$ ${widget.cartPrice}',
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(widget.cartUnit),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 100,
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => widget.onTapDelete(context, widget.cartData),
                    child: Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 25,
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // child: Count(
                    //   // id: id,
                    //   productName: widget.cartName,
                    //   productImage: widget.cartImage,
                    //   productId: widget.cartId,
                    //   productPrice: widget.cartPrice,
                    // ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (count == 1) {
                                Fluttertoast.showToast(
                                  msg: "You reached minimum limit",
                                );
                              } else {
                                setState(() {
                                  count--;
                                });
                                reviewCartProvider.updateReviewCartData(
                                  cartId: widget.cartId,
                                  cartName: widget.cartName,
                                  cartImage: widget.cartImage,
                                  cartPrice: widget.cartPrice,
                                  cartQuantity: count,
                                );
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          Text(
                            '$count',
                            style: const TextStyle(
                              color: Color.fromARGB(251, 223, 105, 9),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (count == 6) {
                                Fluttertoast.showToast(
                                    msg: "You reached maximum limit");

                                setState(() {
                                  count = 6;
                                });
                              } else {
                                setState(() {
                                  count++;
                                });
                                reviewCartProvider.updateReviewCartData(
                                  cartId: widget.cartId,
                                  cartName: widget.cartName,
                                  cartImage: widget.cartImage,
                                  cartPrice: widget.cartPrice,
                                  cartQuantity: count,
                                );
                              }
                            },
                            child: Icon(
                              Icons.add,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

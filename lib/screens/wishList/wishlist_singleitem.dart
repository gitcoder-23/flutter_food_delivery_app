import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';

class WishListSingleItem extends StatefulWidget {
  int? id;
  String wishListImage;
  String wishListName;
  int wishListPrice;
  String wishListId;
  int? wishListQuantity;
  Function onTapDeleteWishList;
  WishListSingleItem({
    this.id,
    required this.wishListImage,
    required this.wishListName,
    required this.wishListPrice,
    super.key,
    required this.wishListId,
    this.wishListQuantity,
    required this.onTapDeleteWishList,
  });

  @override
  State<WishListSingleItem> createState() => _WishListSingleItemState();
}

class _WishListSingleItemState extends State<WishListSingleItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: buildSearchedItemList(),
        ),
        const Divider(height: 1, color: Colors.black45)
      ],
    );
  }

  Widget buildSearchedItemList() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Center(child: Image.network(widget.wishListImage)),
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
                      widget.wishListName,
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${widget.wishListPrice} \$',
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Text('50 Kg'),
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
                  GestureDetector(
                    onTap: () =>
                        widget.onTapDeleteWishList(context, widget.wishListId),
                    child: Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.grey[600],
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

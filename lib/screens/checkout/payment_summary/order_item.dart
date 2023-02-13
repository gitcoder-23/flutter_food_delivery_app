import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/models/review_cart_model.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel? e;
  const OrderItem({this.e});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e!.cartImage,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            e!.cartName,
            style: TextStyle(
              color: textColor,
            ),
          ),
          Text(
            "${e!.cartUnit}",
            style: TextStyle(
              color: textColor,
            ),
          ),
          Text(
            "\$${e!.cartPrice}",
          ),
        ],
      ),
      subtitle: Text(
        'Quantity: ${e!.cartQuantity.toString()}',
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}

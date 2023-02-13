import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/components/navigationMenus/drawer_menu.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/screens/wishList/wishlist_singleitem.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcbcbcb),
      drawer: const DrawerMenu(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: headerColor,
        centerTitle: true,
        title: Text(
          'WishList',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: const [
              SizedBox(
                height: 10,
              ),
              // WishListSingleItem(
              //   isBool: true,
              //   productImage:
              //       'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png',
              //   productName: 'HIIII',
              //   productPrice: 10,
              //   productId: 'gjhhjjjhj',
              //   productQuantity: 14,
              // ),
            ],
          )
        ],
      ),
    );
  }
}

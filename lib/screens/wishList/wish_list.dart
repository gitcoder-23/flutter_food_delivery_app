import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/components/navigationMenus/drawer_menu.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/models/wishlist_model.dart';
import 'package:flutter_food_delivery_app/providers/wishlist_provider.dart';
import 'package:flutter_food_delivery_app/screens/wishList/wishlist_singleitem.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  void initState() {
    getAllWishlistProducts();
    super.initState();
  }

  getAllWishlistProducts() async {
    WishListProvider wishListProvider =
        Provider.of<WishListProvider>(context, listen: false);
    if (mounted) {
      wishListProvider.fetchWishtListData();
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      getAllWishlistProducts();
    }
  }

  Future<void> _onRefresh() async {
    try {
      getAllWishlistProducts();
    } catch (e) {
      print('Wish-List-refresh[error]: $e');
    }
  }

  showAlertDialog(BuildContext context, String wishListId) {
    WishListProvider wishListProvider =
        Provider.of<WishListProvider>(context, listen: false);
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kGrey)),
      child: Text(
        "No",
        style: TextStyle(color: textColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(headerColor)),
      child: Text(
        "Yes",
        style: TextStyle(color: textColor),
      ),
      onPressed: () {
        wishListProvider.deleteWishtList(wishListId);
        Navigator.of(context).pop(_onRefresh());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: scaffoldBackgroundColor,
      title: const Text("Wishlist Product"),
      content: const Text("Do you want to delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  onTapDeleteWishList(context, String wishListId) {
    showAlertDialog(context, wishListId);
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);

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
      body: wishListProvider.getWishList.isEmpty
          ? const Center(
              child: Text(
                'No Wishlist Product Found',
              ),
            )
          : RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: wishListProvider.getWishList.length,
                itemBuilder: (context, index) {
                  WishListModel wishListData =
                      wishListProvider.getWishList[index];
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      WishListSingleItem(
                        wishListImage: wishListData.wishListImage,
                        wishListName: wishListData.wishListName,
                        wishListPrice: wishListData.wishListPrice,
                        wishListId: wishListData.wishListId,
                        wishListQuantity: wishListData.wishListQuantity,
                        onTapDeleteWishList: onTapDeleteWishList,
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}

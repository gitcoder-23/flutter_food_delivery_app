import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/components/navigationMenus/drawer_menu.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/models/review_cart_model.dart';
import 'package:flutter_food_delivery_app/providers/review_cart_provider.dart';
import 'package:flutter_food_delivery_app/screens/checkout/delivery_details/delivery_details.dart';
import 'package:flutter_food_delivery_app/widget/review_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatefulWidget {
  final ReviewCartProvider reviewCartProvider;
  const ReviewCart({required this.reviewCartProvider, super.key});

  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  @override
  void initState() {
    getCartProducts();
    widget.reviewCartProvider;
    super.initState();
  }

  getCartProducts() async {
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context, listen: false);

    if (mounted) {
      reviewCartProvider.getReviewCartData();
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      getCartProducts();
    }
  }

  showAlertDialog(BuildContext context, ReviewCartModel cartData) {
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
        widget.reviewCartProvider.deleteReviewCartData(cartData.cartId);
        Navigator.of(context).pop(_onRefresh());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: scaffoldBackgroundColor,
      title: const Text("Cart Product"),
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

  onTapDelete(context, cartData) {
    showAlertDialog(context, cartData);
  }

  Future<void> _onRefresh() async {
    try {
      getCartProducts();
    } catch (e) {
      print('Cart-List-refresh[error]: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      backgroundColor: const Color(0xffcbcbcb),
      drawer: const DrawerMenu(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: headerColor,
        centerTitle: true,
        title: Text(
          'Review Cart',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
      ),
      // reviewCartProvider.getReviewCartDataList.isNotEmpty
      body: reviewCartProvider.getReviewCartDataList.isEmpty
          ? const Center(
              child: Text(
                'No Product in Cart',
              ),
            )
          : RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: reviewCartProvider.getReviewCartDataList.length,
                itemBuilder: (context, index) {
                  final cartData =
                      reviewCartProvider.getReviewCartDataList[index];
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ReviewItem(
                        onTapDelete: onTapDelete,
                        cartId: cartData.cartId,
                        cartName: cartData.cartName,
                        cartImage: cartData.cartImage,
                        cartPrice: cartData.cartPrice,
                        cartQuantity: cartData.cartQuantity,
                        cartUnit: cartData.cartUnit,
                        cartData: cartData,
                        context: context,
                      ),
                    ],
                  );
                },
              ),
            ),

      // body: ListView(
      //   children: const [
      //     SizedBox(
      //       height: 10,
      //     ),
      //     ReviewItem(),
      //     SizedBox(
      //       height: 10,
      //     ),
      //   ],
      // ),
    );
  }

  Widget buildBottomNavigationBar() {
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);

    return ListTile(
      title: reviewCartProvider.getReviewCartDataList.isEmpty
          ? const Text('')
          : const Text('Total Amount'),
      subtitle: reviewCartProvider.getReviewCartDataList.isEmpty
          ? const Text('')
          : Text(
              '\$ ${reviewCartProvider.getTotalPriceInCart()}',
              style: TextStyle(color: Colors.green[900]),
            ),
      trailing: SizedBox(
        width: 160,
        child: reviewCartProvider.getReviewCartDataList.isEmpty
            ? const Text('')
            : MaterialButton(
                onPressed: () {
                  if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                    Fluttertoast.showToast(msg: 'No Cart Data Found!');
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DeliveryDetails(),
                    ));
                  }
                },
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: const Text('Submit'),
              ),
      ),
    );
  }
}

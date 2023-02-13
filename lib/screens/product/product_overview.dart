import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/components/navigationMenus/bottom_menu.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/helpers/functions.dart';
import 'package:flutter_food_delivery_app/providers/review_cart_provider.dart';
import 'package:flutter_food_delivery_app/providers/wishlist_provider.dart';
import 'package:flutter_food_delivery_app/screens/home_screen.dart';
import 'package:flutter_food_delivery_app/screens/review_cart/review_cart.dart';
import 'package:provider/provider.dart';

enum SigninCharacter { fill, outLine }

class ProductOverview extends StatefulWidget {
  final int? id;
  final String? productId;
  final String? productImage;
  final String? productName;
  final int? productPrice;
  final String? productUnit;
  const ProductOverview({
    this.id,
    this.productId,
    this.productImage,
    this.productName,
    this.productPrice,
    this.productUnit,
    super.key,
  });

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  SigninCharacter _character = SigninCharacter.fill;

  bool wishListBool = false;

  @override
  void initState() {
    getWishListBool();
    super.initState();
  }

  getWishListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (mounted)
                {
                  if (value.exists)
                    {
                      setState(
                        () {
                          wishListBool = value.get("wishList");
                        },
                      ),
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    // print('ProductOverview--> ${widget.productImage}');
    // getWishListBool();
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 162, 34, 34),

        // drawer: const DrawerMenu(),
        bottomNavigationBar: buildNavMenuBar(),
        appBar: AppBar(
          backgroundColor: headerColor,
          iconTheme: IconThemeData(color: textColor),
          title: Text(
            'Product Overview',
            style: TextStyle(color: textColor),
          ),
          // Leading add to mount the previous window
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
          ),
        ),
        // body: Column
        body: ListView(
          children: [
            buildProductOverview(),
            SizedBox(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About This Product',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget buildNavMenuBar() {
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);

    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);
    return Row(
      children: [
        BottomNavigationMenu(
          iconColor: kGrey,
          backgroundColor: textColor,
          color: kWhite,
          title: "Add to Wishlist",
          iconData:
              wishListBool == false ? Icons.favorite_outline : Icons.favorite,
          onTapBottomButton: () {
            // print("Add to Wishlist");
            setState(() {
              // If false then true & If true yhen false by click
              wishListBool = !wishListBool;
            });
            if (wishListBool == true) {
              wishListProvider.addWishListData(
                wishListId: widget.productId,
                wishListName: widget.productName,
                wishListImage: widget.productImage,
                wishListPrice: widget.productPrice,
                wishListQuantity: 1,
              );
              showToast(
                context,
                'Product added to wishlist',
              );
            } else {
              wishListProvider.deleteWishtList(widget.productId.toString());

              showToast(
                context,
                'Product removed from wishlist',
              );
            }
          },
        ),
        BottomNavigationMenu(
          iconColor: textColor,
          backgroundColor: primaryColor,
          color: textColor,
          title: "Go to Cart",
          iconData: Icons.shop_outlined,
          onTapBottomButton: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ReviewCart(reviewCartProvider: reviewCartProvider),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildProductOverview() {
    return SizedBox(
      // flex: 2,
      child: SizedBox(
        width: double.infinity,
        child: Column(children: [
          ListTile(
            title: Text(widget.productName!),
            subtitle: Text('\$ ${widget.productPrice}'),
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.all(40),
            child: Image.network((widget.productImage!)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Text(
              'Available Options',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          availableOptionDetails(),
        ]),
      ),
    );
  }

  Widget availableOptionDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // margin: const EdgeInsets.only(right: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 3,
                backgroundColor: Colors.green[700],
              ),
              Radio(
                activeColor: Colors.green[700],
                value: SigninCharacter.fill,
                groupValue: _character,
                onChanged: (value) {
                  // print('value--> $value');
                  setState(() {
                    _character = value!;
                  });
                },
              ),
            ],
          ),
          Text("\$ ${widget.productPrice} \$/${widget.productUnit}"),
          // Count Added
          // SizedBox(
          //   width: 100,
          //   child: Count(
          //     id: widget.id!,
          //     productName: widget.productName!,
          //     productImage: widget.productImage!,
          //     productId: widget.productId!,
          //     productPrice: widget.productPrice!,
          //   ),
          // ),

          // Container(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 30,
          //     vertical: 10,
          //   ),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.grey),
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //     Icon(
          //       Icons.add,
          //       size: 17,
          //       color: textColor,
          //     ),
          //     Text(
          //       "Add",
          //       style: TextStyle(color: textColor),
          //     ),
          //   ]),
          // ),
        ],
      ),
    );
  }
}

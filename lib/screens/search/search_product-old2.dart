import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/models/product_model.dart';
import 'package:flutter_food_delivery_app/widget/single_item.dart';

class SearchProduct extends StatefulWidget {
  final List<ProductModel>? search;
  final String? productCategory;
  final bool? isProductList;
  const SearchProduct(
      {this.search, this.productCategory, this.isProductList, super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawerMenu(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: headerColor,
        centerTitle: true,
        title: Text(
          widget.isProductList == true ? widget.productCategory! : 'Search',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.filter_alt_outlined),
          ),
        ],
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(
        //         Icons.remove_red_eye_sharp,
        //         color: Colors.red, // Change Custom Drawer Icon Color
        //       ),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //     );
        //   },
        // ),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Items'),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 52,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: const Color(0xffc2c2c2),
                filled: true,
                hintText: "Search for items in the store",
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          widget.isProductList == true
              ? Column(
                  children: widget.search!.map((data) {
                    return SingleItem(
                      isBool: false,
                      id: data.id,
                      productImage: data.productImage,
                      productName: data.productName,
                      productPrice: data.productPrice,
                    );
                  }).toList(),
                )
              : Column(children: [
                  SingleItem(
                    isBool: false,
                    id: 1,
                    productImage:
                        'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png',
                    productName: 'productName',
                    productPrice: 50,
                  ),
                  SingleItem(
                    isBool: false,
                    id: 1,
                    productImage:
                        'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png',
                    productName: 'productName',
                    productPrice: 50,
                  ),
                  SingleItem(
                    isBool: false,
                    id: 1,
                    productImage:
                        'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png',
                    productName: 'productName',
                    productPrice: 50,
                  ),
                  SingleItem(
                    isBool: false,
                    id: 1,
                    productImage:
                        'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png',
                    productName: 'productName',
                    productPrice: 50,
                  ),
                ]),
        ],
      ),
    );
  }
}

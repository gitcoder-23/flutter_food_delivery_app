import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/models/product_model.dart';
import 'package:flutter_food_delivery_app/screens/home_screen.dart';
import 'package:flutter_food_delivery_app/widget/single_item.dart';

class SearchProduct extends StatefulWidget {
  final List<ProductModel> search;
  final String? productCategory;
  final bool? isProductList;
  const SearchProduct(
      {required this.search,
      this.productCategory,
      this.isProductList,
      super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  String query = "";

  // Search Function
  List<ProductModel> searchProductItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName!.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> searchItem = searchProductItem(query);

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
          ListTile(
            title: Text(widget.isProductList == false ? 'All Items' : 'Items'),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 52,
            child: TextField(
              onChanged: (value) {
                // print('@@value--> $value');
                setState(() {
                  query = value;
                });
              },
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
          Column(
            // Using Query Search
            children: searchItem.map((data) {
              return SingleItem(
                isBool: false,
                id: data.id,
                productId: data.productId,
                productImage: data.productImage,
                productName: data.productName,
                productPrice: data.productPrice,
                productUnit: data.productUnit,
              );
            }).toList(),
          ),

          // widget.isProductList == true
          //     ? Column(
          //         // Using Query Search
          //         children: searchItem.map((data) {
          //           return SingleItem(
          //             isBool: false,
          //             id: data.id,
          //             productImage: data.productImage,
          //             productName: data.productName,
          //             productPrice: data.productPrice,
          //           );
          //         }).toList(),
          //         // children: widget.search.map((data) {
          //         //   return SingleItem(
          //         //     isBool: false,
          //         //     id: data.id,
          //         //     productImage: data.productImage,
          //         //     productName: data.productName,
          //         //     productPrice: data.productPrice,
          //         //   );
          //         // }).toList(),
          //       )
          //     : Column(children: [
          //         SingleItem(
          //           isBool: false,
          //           id: 1,
          //           productImage:
          //               'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png',
          //           productName: 'productName',
          //           productPrice: 50,
          //         ),
          //         SingleItem(
          //           isBool: false,
          //           id: 1,
          //           productImage:
          //               'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png',
          //           productName: 'productName',
          //           productPrice: 50,
          //         ),
          //         SingleItem(
          //           isBool: false,
          //           id: 1,
          //           productImage:
          //               'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png',
          //           productName: 'productName',
          //           productPrice: 50,
          //         ),
          //         SingleItem(
          //           isBool: false,
          //           id: 1,
          //           productImage:
          //               'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png',
          //           productName: 'productName',
          //           productPrice: 50,
          //         ),
          //       ]),
        ],
      ),
    );
  }
}

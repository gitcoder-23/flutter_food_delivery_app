import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/components/navigationMenus/drawer_menu.dart';
import 'package:flutter_food_delivery_app/components/single_product.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/providers/product_provider.state.dart';
import 'package:flutter_food_delivery_app/providers/review_cart_provider.dart';
import 'package:flutter_food_delivery_app/providers/user_provider.dart';
import 'package:flutter_food_delivery_app/screens/product/product_overview.dart';
import 'package:flutter_food_delivery_app/screens/review_cart/review_cart.dart';
import 'package:flutter_food_delivery_app/screens/search/search_product.dart';
import 'package:flutter_food_delivery_app/widget/landing_loading.dart';
import 'package:provider/provider.dart';

// OutlinedButton MaterialButton Opacity

const String productName1 = 'Fresh Besil';
const String productName2 = 'Fresh Fruit';
const String productName3 = 'Fresh Vegetable';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getCurrentUserCall();
    getAllHerbProducts();
    super.initState();
  }

  getCurrentUserCall() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    if (mounted) {
      userProvider.fetchCurrentUserData();
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      getCurrentUserCall();
    }
  }

  getAllHerbProducts() async {
    ProductProviderState productProviderState =
        Provider.of<ProductProviderState>(context, listen: false);

    if (mounted) {
      productProviderState.fetchHerbsProductData();
      productProviderState.fetchFruitProductData();
      productProviderState.fetchVegetableProductData();
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      getAllHerbProducts();
    }
  }

  onTap(int id, String productId, String productImage, String productName,
      int productPrice, productUnit) async {
    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductOverview(
            id: id,
            productId: productId,
            productImage: productImage,
            productName: productName,
            productPrice: productPrice,
            productUnit: productUnit,
          ),
        ),
      );
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      onTap(
          id, productId, productImage, productName, productPrice, productUnit);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    ProductProviderState productProviderState =
        Provider.of<ProductProviderState>(context);

    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);

    return productProviderState.getHerbsProductDataList.isEmpty
        ? const LandingLoading()
        : Scaffold(
            backgroundColor: const Color(0xffcbcbcb),
            drawer: const DrawerMenu(),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: headerColor,
              centerTitle: true,
              title: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              actions: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xffd4d181),
                  // child: Icon(
                  //   Icons.search,
                  //   size: 17,
                  //   color: Colors.black,
                  // ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => SearchProduct(
                                  // get full search
                                  // search: productProviderState.getAllProductSearch,
                                  search: productProviderState.searchAllProduct,
                                  productCategory: '',
                                  isProductList: false,
                                )),
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xffd4d181),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ReviewCart(
                                reviewCartProvider: reviewCartProvider),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shop,
                        size: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: buildMainContent(),
            ),
          );
  }

  Widget buildMainContent() {
    ProductProviderState productProviderState =
        Provider.of<ProductProviderState>(context);

    return ListView(
      children: [
        bannerMainContent(),
        herbFruitSeasonLabel(title: 'Herbs Seasonings', type: 'herbs'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProviderState.getHerbsProductDataList.map(
              (herbsData) {
                return SinglePoduct(
                  onTap: onTap,
                  id: herbsData.id,
                  productId: herbsData.productId,
                  productImage: herbsData.productImage,
                  productName: herbsData.productName,
                  productPrice: herbsData.productPrice,
                  productUnit: herbsData.productUnit,
                );
              },
            ).toList(),
          ),
        ),
        herbFruitSeasonLabel(title: 'Fresh Fruits', type: 'fruits'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProviderState.getFruitProductDataList.map(
              (fruitData) {
                return SinglePoduct(
                  onTap: onTap,
                  id: fruitData.id,
                  productId: fruitData.productId,
                  productImage: fruitData.productImage,
                  productName: fruitData.productName,
                  productPrice: fruitData.productPrice,
                  productUnit: fruitData.productUnit,
                );
              },
            ).toList(),
          ),
        ),
        herbFruitSeasonLabel(title: 'Root Vegetables', type: 'vege'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProviderState.getVegeProductDataList.map(
              (vegeData) {
                return SinglePoduct(
                  onTap: onTap,
                  id: vegeData.id,
                  productId: vegeData.productId,
                  productImage: vegeData.productImage,
                  productName: vegeData.productName,
                  productPrice: vegeData.productPrice,
                  productUnit: vegeData.productUnit,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget herbFruitSeasonLabel({required String title, required String type}) {
    ProductProviderState productProviderState =
        Provider.of<ProductProviderState>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          GestureDetector(
            onTap: () {
              if (type == 'herbs') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchProduct(
                          search: productProviderState.getHerbsProductDataList,
                          productCategory: title,
                          isProductList: true,
                        )));
              } else if (type == 'fruits') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchProduct(
                          search: productProviderState.getFruitProductDataList,
                          productCategory: title,
                          isProductList: true,
                        )));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchProduct(
                          search: productProviderState.getVegeProductDataList,
                          productCategory: title,
                          isProductList: true,
                        )));
              }
            },
            child: const Text(
              'View all',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget bannerMainContent() {
    return Container(
      height: 150,
      // color: Colors.red, // Testing
      decoration: BoxDecoration(
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/02/healthy-eaiting-groceries-vegetables-1296x728-header.jpg?w=1155&h=1528'),
        ),
        color: Colors.red,
        // color: const Color(0xFF0E3311).withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),

      // padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              // color: Colors.red,
              color: const Color(0xFF0E3311).withOpacity(0.4),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 110,
                      bottom: 20,
                    ),
                    child: Container(
                      height: 45,
                      width: 140,
                      // color: Colors.blue,
                      decoration: const BoxDecoration(
                        color: Color(0xffd1ad17),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 12, top: 8),
                        child: Text(
                          'Vegi',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 10,
                                offset: Offset(3, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    '30% off',
                    style: TextStyle(
                        backgroundColor: Colors.green,
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'On all vegetables products',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              color: const Color(0xFF0E3311).withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}

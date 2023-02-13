// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/models/product_model.dart';

class ProductProviderState with ChangeNotifier {
  late ProductModel productModel;
  List<ProductModel> searchAllProduct = [];
  List<ProductModel> herbsProductList = [];
  List<ProductModel> fruitProductList = [];
  List<ProductModel> vegeProductList = [];

  productListModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      id: element.get('id'),
      productId: element.get('productId'),
      productImage: element.get('productImage'),
      productName: element.get('productName'),
      productPrice: element.get('productPrice'),
      productUnit: element.get('productUnit'),
    );
  }

  ///////////////////Herb Product/////////////////////

  fetchHerbsProductData() async {
    try {
      List<ProductModel> newProductList = [];
      // Firebase collection name -> "HerbsProduct"
      QuerySnapshot value =
          await FirebaseFirestore.instance.collection("HerbsProduct").get();

      // print('@@Fetch.herb.product--> $value');
      value.docs.forEach((element) {
        // print('@@Fetch.herb.product.state-> ${element.data()}');
        productListModels(element);
        newProductList.add(productModel);
      });
      herbsProductList = newProductList;
      // herbsProductList.clear();

      /// like setState
      notifyListeners();
      // return herbsProductList;
    } catch (e) {
      print('@@@fetchHerbsProductData-error: $e');
      rethrow;
    }
  }

  List<ProductModel> get getHerbsProductDataList {
    return herbsProductList;
  }

  ////////////////Fruit Product/////////////////////

  fetchFruitProductData() async {
    try {
      List<ProductModel> newProductList = [];
      // Firebase collection name -> "HerbsProduct"
      QuerySnapshot value =
          await FirebaseFirestore.instance.collection("FruitProduct").get();

      // print('@@Fetch.fruit.product--> $value');
      value.docs.forEach((element) {
        // print('@@Fetch.fruit.product.state-> ${element.data()}');
        productModel = ProductModel(
          id: element.get('id'),
          productId: element.get('productId'),
          productImage: element.get('productImage'),
          productName: element.get('productName'),
          productPrice: element.get('productPrice'),
          productUnit: element.get('productUnit'),
        );
        newProductList.add(productModel);
      });
      fruitProductList = newProductList;
      // fruitProductList.clear();

      /// like setState
      notifyListeners();
      // return herbsProductList;
    } catch (e) {
      print('@@@fetchFruitProductData-error: $e');
      rethrow;
    }
  }

  List<ProductModel> get getFruitProductDataList {
    return fruitProductList;
  }

  ///////////////////Vege Product//////////////////////

  fetchVegetableProductData() async {
    try {
      List<ProductModel> newProductList = [];
      // Firebase collection name -> "HerbsProduct"
      QuerySnapshot value =
          await FirebaseFirestore.instance.collection("VegetableProduct").get();

      // print('@@Fetch.vege.product--> $value');
      value.docs.forEach((element) {
        // print('@@Fetch.vege.product.state-> ${element.data()}');
        productModel = ProductModel(
          id: element.get('id'),
          productId: element.get('productId'),
          productImage: element.get('productImage'),
          productName: element.get('productName'),
          productPrice: element.get('productPrice'),
          productUnit: element.get('productUnit'),
        );
        newProductList.add(productModel);
      });
      vegeProductList = newProductList;
      // fruitProductList.clear();

      /// like setState
      notifyListeners();
      // return herbsProductList;
    } catch (e) {
      print('@@@fetchFruitProductData-error: $e');
      rethrow;
    }
  }

  List<ProductModel> get getVegeProductDataList {
    return vegeProductList;
  }
}

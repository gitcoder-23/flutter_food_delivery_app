// ignore_for_file: prefer_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/widget/count.dart';
import 'package:flutter_food_delivery_app/widget/product_unit.dart';

class SinglePoduct extends StatefulWidget {
  final Function onTap;
  final int? id;
  final String? productId;
  final String? productImage;
  final String? productName;
  final int? productPrice;
  List<dynamic>? productUnit;
  SinglePoduct(
      {required this.onTap,
      this.id,
      this.productId,
      this.productImage,
      this.productName,
      this.productPrice,
      this.productUnit,
      super.key});

  @override
  State<SinglePoduct> createState() => _SinglePoductState();
}

class _SinglePoductState extends State<SinglePoduct> {
  // int count = 0;
  int count = 1;

  // For Product Unit
  var unitData;
  var firstIndexUnit;

  bool isTrue = false;
  @override
  void initState() {
    getAddAndQuantity();
    super.initState();
  }

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviewCart')
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (mounted)
                {
                  if (value.exists)
                    {
                      // print('getAddAndQuantity:-> $value'),
                      setState(() {
                        // update count
                        count = value.get("cartQuantity");
                        unitData = value.get("cartUnit");
                        // isAdd -- boolean
                        isTrue = value.get('isAdd');
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    // by default first unit visible
    widget.productUnit!.firstWhere((getFirstUnit) {
      setState(() {
        firstIndexUnit = getFirstUnit;
      });
      return true;
    });

    // showBottomSheetFunction---> OPS
    showBottomSheetFunction() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.productUnit!.map<Widget>((uData) {
                return Column(
                  children: [
                    ListTile(
                      // leading: const Icon(Icons.photo),
                      title: Text(
                        uData,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      onTap: () async {
                        setState(() {
                          unitData = uData;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: Text(
                    //     uData,
                    //     style: TextStyle(fontSize: 18, color: (primaryColor)),
                    //   ),
                    // )
                  ],
                );
              }).toList(),
              // children: <Widget>[
              // ListTile(
              //   // leading: const Icon(Icons.photo),
              //   title: const Text('50 Gram'),
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              // ),
              // ],
            );
          });
    }
    // showBottomSheetFunction---> OPS End

    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: MediaQuery.of(context).size.width * 0.70,
      width: 170,
      // color: Colors.grey,
      decoration: BoxDecoration(
        color: const Color(0xffd9dad9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => widget.onTap(
              widget.id,
              widget.productId,
              widget.productImage,
              widget.productName,
              widget.productPrice,
              firstIndexUnit,
            ),
            child: Container(
              // margin: const EdgeInsets.only(top: 14.0),
              height: 150,
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              child: Image.network(
                widget.productImage ?? '',
                // width: 150,
              ),
            ),
          ),
          Expanded(
            // flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (unitData == null || unitData == '250 Gram')
                    Text(
                      '${widget.productPrice!}\$/${unitData ?? firstIndexUnit}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (unitData == '500 Gram')
                    Text(
                      '${widget.productPrice! * 2}\$/${unitData ?? firstIndexUnit}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (unitData == '1 Kg')
                    Text(
                      '${widget.productPrice! * 4}\$/${unitData ?? firstIndexUnit}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: ProductUnit(
                          unitData:
                              unitData == null ? firstIndexUnit : unitData,
                          showBottomSheetFunction: showBottomSheetFunction,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (unitData == null || unitData == '250 Gram')
                        buildIncrementDecrement(
                          widget.id,
                          widget.productId,
                          widget.productName,
                          widget.productImage,
                          widget.productPrice,
                          unitData,
                          firstIndexUnit,
                        ),
                      if (unitData == '500 Gram')
                        buildIncrementDecrement(
                          widget.id,
                          widget.productId,
                          widget.productName,
                          widget.productImage,
                          widget.productPrice! * 2,
                          unitData,
                          firstIndexUnit,
                        ),
                      if (unitData == '1 Kg')
                        buildIncrementDecrement(
                          widget.id,
                          widget.productId,
                          widget.productName,
                          widget.productImage,
                          widget.productPrice! * 4,
                          unitData,
                          firstIndexUnit,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildIncrementDecrement(id, productId, productName, productImage,
      productPrice, unitData, firstIndexUnit) {
    return Count(
      id: id,
      productName: productName,
      productImage: productImage,
      productId: productId,
      productPrice: productPrice,
      productUnit: unitData == null ? firstIndexUnit : unitData,
    );
  }
}

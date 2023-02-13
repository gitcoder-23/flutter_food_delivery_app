// ignore_for_file: prefer_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/widget/count.dart';

class SingleItem extends StatefulWidget {
  bool? isBool = false;
  int? id;
  String? productId;
  String? productImage;
  String? productName;
  int? productPrice;
  List<dynamic>? productUnit;
  SingleItem(
      {this.isBool,
      this.id,
      this.productId,
      this.productImage,
      this.productName,
      this.productPrice,
      this.productUnit,
      super.key});

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  // int count = 0;
  int count = 1;

  // For Product Unit
  var unitData;
  var changedUnit;
  var firstIndexUnit;

  bool isTrue = false;

  @override
  void initState() {
    getAddQuantityAndUnit();
    super.initState();
  }

  getAddQuantityAndUnit() {
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
                      print('getAddAndQuantity:-> ${value.get("cartUnit")}'),
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

    print('@@@@unitData---> $unitData');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: buildSearchedItemList(context),
        ),
        widget.isBool == false
            ? Container()
            : const Divider(height: 1, color: Colors.black45)
      ],
    );
  }

  Widget buildSearchedItemList(context) {
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
                          changedUnit = uData;
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

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Center(child: Image.network(widget.productImage!)),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 90,
            child: Column(
              mainAxisAlignment: widget.isBool == false
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName!,
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),

                    if (unitData == null || unitData == '250 Gram')
                      Text(
                        '${widget.productPrice!}\$',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (unitData == '500 Gram')
                      Text(
                        '${widget.productPrice! * 2}\$',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (unitData == '1 Kg')
                      Text(
                        '${widget.productPrice! * 4}\$',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    // Text(
                    //   '\$${widget.productPrice.toString()}',
                    //   style: TextStyle(
                    //       color: textColor, fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
                widget.isBool == false
                    ? GestureDetector(
                        onTap: showBottomSheetFunction,
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(color: textColor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  unitData == null ? firstIndexUnit : unitData,
                                  style: const TextStyle(
                                    // color: kGrey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Center(
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                  color: primaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Text(unitData == null ? firstIndexUnit : unitData),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 100,
            padding: widget.isBool == false
                ? const EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                : const EdgeInsets.only(left: 15, right: 15),
            child: widget.isBool == false
                ? // Count Added
                SizedBox(
                    width: 100,
                    child: buildCounter(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: scaffoldBackgroundColor,
                                  size: 20,
                                ),
                                Text(
                                  'ADD',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget buildCounter() {
    return Column(
      children: [
        if (unitData == null || unitData == '250 Gram')
          Count(
            id: widget.id!,
            productName: widget.productName!,
            productImage: widget.productImage!,
            productId: widget.productId!,
            productPrice: widget.productPrice!,
            productUnit: unitData == null ? firstIndexUnit : unitData,
          ),
        if (unitData == '500 Gram')
          Count(
            id: widget.id!,
            productName: widget.productName!,
            productImage: widget.productImage!,
            productId: widget.productId!,
            productPrice: widget.productPrice! * 2,
            productUnit: unitData == null ? firstIndexUnit : unitData,
          ),
        if (unitData == '1 Kg')
          Count(
            id: widget.id!,
            productName: widget.productName!,
            productImage: widget.productImage!,
            productId: widget.productId!,
            productPrice: widget.productPrice! * 4,
            productUnit: unitData == null ? firstIndexUnit : unitData,
          ),
      ],
    );
  }
}

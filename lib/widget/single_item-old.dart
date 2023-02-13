import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';

class SingleItem extends StatelessWidget {
  bool? isBool = false;
  int? id;
  String? productImage;
  String? productName;
  int? productPrice;
  SingleItem(
      {this.isBool,
      this.id,
      this.productImage,
      this.productName,
      this.productPrice,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: buildSearchedItemList(),
        ),
        isBool == false
            ? Container()
            : const Divider(height: 1, color: Colors.black45)
      ],
    );
  }

  Widget buildSearchedItemList() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Center(
                child: Image.network(
                    'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png')),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 90,
            child: Column(
              mainAxisAlignment: isBool == false
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ProductName',
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '50\$',
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                isBool == false
                    ? Container(
                        margin: const EdgeInsets.only(right: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '50 Gram',
                                style: TextStyle(
                                  color: kGrey,
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
                      )
                    : const Text('50 Kg'),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 100,
            padding: isBool == false
                ? const EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                : const EdgeInsets.only(left: 15, right: 15),
            child: isBool == false
                ? Container(
                    height: 25,
                    width: 50,
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
                            color: primaryColor,
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
                                  color: primaryColor,
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
}

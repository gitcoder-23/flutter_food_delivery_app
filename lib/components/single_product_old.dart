import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/widget/count.dart';

class SinglePoductOld extends StatefulWidget {
  final Function onTap;
  final int? id;
  final String? productId;
  final String? productImage;
  final String? productName;
  final int? productPrice;
  const SinglePoductOld(
      {required this.onTap,
      this.id,
      this.productId,
      this.productImage,
      this.productName,
      this.productPrice,
      super.key});

  @override
  State<SinglePoductOld> createState() => _SinglePoductOldState();
}

class _SinglePoductOldState extends State<SinglePoductOld> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: MediaQuery.of(context).size.width * 0.62,
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
            onTap: () => widget.onTap(widget.id, widget.productId,
                widget.productImage, widget.productName, widget.productPrice),
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
                  Text(
                    '${widget.productPrice}\$/50 Gram',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.only(left: 5),
                        height: 30,
                        width: 50,
                        // color: Colors.black,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: const [
                            Expanded(
                                child: Text(
                              '50 Gram',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            )),
                            Center(
                              child: Icon(
                                size: 20,
                                Icons.arrow_drop_down,
                                color: Color(0xffd0b84c),
                              ),
                            )
                          ],
                        ),
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      buildIncrementDecrement(
                        widget.id,
                        widget.productId,
                        widget.productName,
                        widget.productImage,
                        widget.productPrice,
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

  Widget buildIncrementDecrement(
      id, productId, productName, productImage, productPrice) {
    return Count(
      id: id,
      productName: productName,
      productImage: productImage,
      productId: productId,
      productPrice: productPrice,
    );
  }
}

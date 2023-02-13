// ignore_for_file: prefer_if_null_operators

import 'package:flutter/material.dart';

class ProductUnit extends StatefulWidget {
  String? unitData;
  final Function? showBottomSheetFunction;
  ProductUnit({
    this.unitData,
    this.showBottomSheetFunction,
    super.key,
  });

  @override
  State<ProductUnit> createState() => _ProductUnitState();
}

class _ProductUnitState extends State<ProductUnit> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          widget.showBottomSheetFunction ?? widget.showBottomSheetFunction!(),
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
          children: [
            Expanded(
                child: Text(
              '${widget.unitData}',
              style: const TextStyle(
                fontSize: 12,
              ),
            )),
            const Center(
              child: Icon(
                size: 20,
                Icons.arrow_drop_down,
                color: Color(0xffd0b84c),
              ),
            )
          ],
        ),
      ),
    );
  }
}

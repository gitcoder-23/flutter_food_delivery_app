import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labText;
  final TextInputType? keyboardType;
  final Icon? fieldIcon;
  const CustomTextField({
    this.controller,
    this.keyboardType,
    this.labText,
    this.fieldIcon,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: keyboardType,
        controller: controller,
        // focusNode: ,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          labelText: labText,
          icon: fieldIcon,
          // enabledBorder: const OutlineInputBorder(),

          // focusedBorder: const OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.red, width: 2.0),
          // ),
        ));
  }
}

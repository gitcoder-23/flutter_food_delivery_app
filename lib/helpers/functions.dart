import 'package:flutter/material.dart';

void showToast(BuildContext ctx, String msg) {
  // return SnackBar(content: Text('Yay! A SnackBar!'));
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));
}

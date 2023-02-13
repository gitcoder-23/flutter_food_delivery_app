import 'package:flutter/material.dart';

class BottomNavigationMenu extends StatelessWidget {
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? color;
  final String? title;
  final IconData? iconData;
  final Function? onTapBottomButton;
  const BottomNavigationMenu(
      {this.iconColor,
      this.backgroundColor,
      this.color,
      this.title,
      this.iconData,
      this.onTapBottomButton,
      super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTapBottomButton ?? onTapBottomButton!(),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              iconData,
              size: 20,
              color: iconColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title!,
              style: TextStyle(
                color: color,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

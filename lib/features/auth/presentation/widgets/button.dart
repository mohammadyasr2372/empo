import 'package:flutter/material.dart';

import '../../../../core/strings/color.dart';

class ButtonAuth extends StatelessWidget {
  final double width;
  final String title;
  final void Function() onPressed;
  final Color? colorBag;
  final Color? colorText;
  final Widget? icon;
  const ButtonAuth(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.width,
      this.colorBag,
      this.colorText,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onPressed,
        color: (colorBag == null) ? SelectedButtonColor : colorBag,
        textColor: (colorText == null) ? UnSelectedButtonColor : colorText,
        minWidth: 280,
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextNavigator extends StatelessWidget {
  final String title;
  final String textNav;
  final void Function()? onTap;
  const TextNavigator(
      {super.key, required this.title, required this.textNav, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black45,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            textNav,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

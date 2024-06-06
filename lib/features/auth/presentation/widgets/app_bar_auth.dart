// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../../../../core/strings/color.dart';
import '../../../../core/strings/constans.dart';

class AppBarAuth extends StatelessWidget {
  bool isUserSelected;
  void Function() onPressedVendor;
  void Function() onPressedUser;
  AppBarAuth({
    super.key,
    required this.isUserSelected,
    required this.onPressedVendor,
    required this.onPressedUser,
  });

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(right: 19.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonAppBar(
                onPressed: onPressedVendor,
                isSelected: !isUserSelected,
                title: 'Vendor'),
            ButtonAppBar(
                onPressed: onPressedUser,
                isSelected: isUserSelected,
                title: 'User'),
          ],
        ),
      ),
    );
  }
}

class ButtonAppBar extends StatelessWidget {
  final void Function() onPressed;
  final bool isSelected;
  final String title;

  const ButtonAppBar(
      {super.key,
      required this.onPressed,
      required this.isSelected,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 40),
      child: MaterialButton(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onPressed,
        color: isSelected ? SelectedButtonColor : UnSelectedButtonColor,
        minWidth: width / 3,
        height: height / 17,
        textColor: isSelected ? Colors.white : Colors.black,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

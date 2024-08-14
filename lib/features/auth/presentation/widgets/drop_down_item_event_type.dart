import 'package:flutter/material.dart';

import '../../../../core/strings/constans.dart';

// String selectedValue = 'Wedding Hall';

class DropDownItemEvent extends StatefulWidget {
  const DropDownItemEvent({super.key});

  @override
  State<DropDownItemEvent> createState() => _DropDownItemEventState();
}

class _DropDownItemEventState extends State<DropDownItemEvent> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return SizedBox(
        width: width / 2,
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: (item) => setState(() {
            selectedValue = item;
          }),
          items: itemList
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.grey[200],
            filled: true,
            labelText: "Event Type",
          ),
        ));
  }
}

List<String> itemList = ['Wedding Hall', 'Hotal', 'Restorant', 'Candies shop'];
String? selectedValue = itemList.first;

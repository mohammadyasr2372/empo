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

List<String> itemList = ['Wedding Hall', 'Hotal', 'Restorant'];
String? selectedValue = itemList.first;
// List<DropdownMenuItem<String>> dropdownItems = [
//   const DropdownMenuItem(
//     value: 'Wedding Hall',
//     child: Text('Wedding Hall'),
//   ),
//   const DropdownMenuItem(
//     value: 'Candies shop',
//     child: Text('Candies shop'),
//   ),
//   const DropdownMenuItem(
//     value: 'Decoration shop',
//     child: Text('Decoration shop'),
//   ),
//   const DropdownMenuItem(
//     value: 'Hotal',
//     child: Text('Hotal'),
//   ),
//   const DropdownMenuItem(
//     value: 'Car rental shop',
//     child: Text('Car rental shop'),
//   ),
//   const DropdownMenuItem(
//     value: 'Restorant',
//     child: Text('Restorant'),
//   ),
// ];

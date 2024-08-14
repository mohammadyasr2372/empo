import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;

  DropdownWidget({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.purple,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: Colors.purple,
              hint: Text(
                hint,
                style: TextStyle(color: Colors.white),
              ),
              value: value,
              onChanged: onChanged,
              items: items.map((item) {
                return DropdownMenuItem(
                  child: Text(
                    item,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  value: item,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextFromFieldForAuth extends StatelessWidget {
  final bool obscureText;
  final TextEditingController textEditingController;
  final Icon icon;
  final String title;
  final String hintText;
  final String? Function(String?)? validator;
  const TextFromFieldForAuth(
      {super.key,
      required this.icon,
      required this.title,
      required this.hintText,
      required this.textEditingController,
      this.validator,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: TextFormField(
              obscureText: obscureText,
              validator: (validator == null)
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter $title';
                      }
                      return null;
                    }
                  : validator,
              controller: textEditingController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                fillColor: Colors.grey[200],
                filled: true,
                prefixIcon: icon,
                hintText: (hintText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

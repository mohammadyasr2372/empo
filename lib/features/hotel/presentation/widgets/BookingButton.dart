// ignore_for_file: library_private_types_in_public_api

// ignore_for_file: file_names, use_super_parameters, sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';

class BookingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BookingButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: const Text(
            'Proceed to Booking',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.deepPurple,
            textStyle: const TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

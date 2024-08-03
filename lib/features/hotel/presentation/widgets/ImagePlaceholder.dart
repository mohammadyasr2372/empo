// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters, file_names
import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  final String? imagePath;

  const ImagePlaceholder({
    Key? key,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath!,
      fit: BoxFit.cover,
    );
  }
}

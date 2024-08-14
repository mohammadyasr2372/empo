// import 'package:flutter/material.dart';

// class ImagePlaceholder extends StatelessWidget {
//   final String? imagePath;

//   const ImagePlaceholder({Key? key, this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Image.network(
//       imagePath!,
//       fit: BoxFit.cover,
//     );
//   }
// }
import 'package:flutter/material.dart';

class ImagePlaceholderWedding extends StatelessWidget {
  final String? imagePath;

  const ImagePlaceholderWedding({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
     'http://localhost:3000/${imagePath!.split('/').last}',
      fit: BoxFit.fill,
    );
  }
}

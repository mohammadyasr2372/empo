// ignore_for_file: use_super_parameters

import 'dart:math';
import 'package:flutter/material.dart';
import 'card_room_carousel.dart';

// class HospitalityCarouselView extends StatelessWidget {
//   final String imagePath;
//   final PageController controller;
//   final int index;

//   const HospitalityCarouselView({
//     Key? key,
//     required this.imagePath,
//     required this.controller,
//     required this.index,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: controller,
//       builder: (context, child) {
//         double value = 0.0;
//         if (controller.position.haveDimensions) {
//           value = index.toDouble() - (controller.page ?? 0);
//           value = (value * 0.038).clamp(-1, 1);
//         }
//         return Transform.rotate(
//           angle: pi * value,
//           child: HospitalityCarouselCard(imagePath: imagePath),
//         );
//       },
//     );
//   }
// }

class HospitalityCarouselView extends StatelessWidget {
  final List<String> imagePaths;
  final PageController pageController;
  final int index;

  const HospitalityCarouselView({
    Key? key,
    required this.imagePaths,
    required this.pageController,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 0.0;
        if (pageController.position.haveDimensions) {
          value = index.toDouble() - (pageController.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
        }
        return Transform.rotate(
          angle: pi * value,
          child: HospitalityCarouselCard(imagePath: imagePaths[index]),
        );
      },
    );
  }
}

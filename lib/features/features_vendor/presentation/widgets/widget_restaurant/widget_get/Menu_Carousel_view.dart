import 'dart:math';
import 'package:flutter/material.dart';

import 'Menu_Carousel_card.dart';

class MenuCarouselview extends StatelessWidget {
  final String imagePath;
  final PageController controller;
  final int index;
  final int price;
    final String Name;


  const MenuCarouselview({
    Key? key,
    required this.imagePath,
    required this.controller,
    required this.index,
    required this.price, required this.Name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 0.0;
        if (controller.position.haveDimensions) {
          value = index.toDouble() - (controller.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
        }
        return Transform.rotate(
          angle: pi * value,
          child: Stack(
            children: [
              MenuCarouselCard(imagePath: imagePath),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  // color: Colors.black54,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        '\$$price', // عرض السعر هنا
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 1,),
                      Text(
                        '$Name', // عرض السعر هنا
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HospitalityCarousel extends StatelessWidget {
  final List<File> images;
  final PageController pageController;
  final VoidCallback pickImage;

  const HospitalityCarousel({
    Key? key,
    required this.images,
    required this.pageController,
    required this.pickImage,
  }) : super(key: key);

  Widget _buildHospitalityCarouselCard(File image) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: FileImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: pageController,
        itemCount: images.length + 1,
        itemBuilder: (context, index) {
          if (index == images.length) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.add_a_photo,
                        color: Colors.white, size: 50),
                    onPressed: pickImage,
                  ),
                ),
              ),
            );
          } else {
            return _buildHospitalityCarouselCard(images[index]);
          }
        },
      ),
    );
  }
}

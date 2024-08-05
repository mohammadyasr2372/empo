// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, use_super_parameters

import 'dart:io';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final List<File> images;
  final PageController pageController;
  final int activePage;
  final VoidCallback onAddImage;

  const ImageSlider({
    Key? key,
    required this.images,
    required this.pageController,
    required this.activePage,
    required this.onAddImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3.4,
              child: images.isNotEmpty
                  ? PageView.builder(
                      controller: pageController,
                      itemCount: images.length,
                      onPageChanged: (value) {
                        // Add functionality to update active page if needed
                      },
                      itemBuilder: (context, index) {
                        return Image.file(
                          images[index],
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.add_a_photo,
                              color: Colors.white, size: 50),
                          onPressed: onAddImage,
                        ),
                      ),
                    ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    images.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: InkWell(
                        onTap: () {
                          pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 10),
                              curve: Curves.easeIn);
                        },
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: activePage == index
                              ? Colors.deepPurple
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: onAddImage,
          child: const Text('Add Hotel Image'),
        ),
      ],
    );
  }
}

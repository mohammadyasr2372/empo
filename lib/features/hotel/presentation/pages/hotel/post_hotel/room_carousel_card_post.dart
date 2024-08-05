// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, use_super_parameters

import 'dart:io';
import 'package:flutter/material.dart';

class RoomCarouselCardPost extends StatelessWidget {
  final List<File> images;
  final PageController pageController;
  final VoidCallback onAddImage;

  const RoomCarouselCardPost({
    Key? key,
    required this.images,
    required this.pageController,
    required this.onAddImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: images.isNotEmpty
              ? PageView.builder(
                  controller: pageController,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: FileImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                  height: 250,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo,
                          color: Colors.white, size: 50),
                      onPressed: onAddImage,
                    ),
                  ),
                ),
        ),
        ElevatedButton(
          onPressed: onAddImage,
          child: const Text('Add Room Image'),
        ),
      ],
    );
  }
}

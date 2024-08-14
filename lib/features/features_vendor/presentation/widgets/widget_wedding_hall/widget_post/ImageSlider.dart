import 'dart:io';

import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final List<File> images;
  final PageController pageController;
  final VoidCallback pickImage;
  final int activePage;

  const ImageSlider({
    Key? key,
    required this.images,
    required this.pageController,
    required this.pickImage,
    required this.activePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3.4,
          child: images.isNotEmpty
              ? PageView.builder(
                  controller: pageController,
                  itemCount: images.length,
                  onPageChanged: (value) {
                    // _activePage needs to be updated in the parent widget's state
                  },
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      // borderRadius: BorderRadius.only(
                      //   bottomLeft: Radius.circular(20),
                      //   bottomRight: Radius.circular(20),
                      // ),
                      child: Image.file(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                )
              : Container(
                  color: Colors.grey,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo,
                          color: Colors.white, size: 50),
                      onPressed: pickImage,
                    ),
                  ),
                ),
        ),
        if (images.isNotEmpty)
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
                            duration: const Duration(milliseconds: 300),
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
    );
  }
}
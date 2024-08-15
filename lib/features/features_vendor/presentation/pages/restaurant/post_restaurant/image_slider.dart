// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, use_super_parameters, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:party/features/features_vendor/presentation/pages/restaurant/post_restaurant/post_restaurant.dart';

class ImageSlider extends StatefulWidget {
  final List<File> images;
  final PageController controller;
  final VoidCallback onAddImage;
  final int activePage;

  const ImageSlider({
    Key? key,
    required this.images,
    required this.controller,
    required this.onAddImage,
    required this.activePage,
  }) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late int _activePage;

  @override
  void initState() {
    super.initState();
    _activePage = widget.activePage;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3.4,
          child: widget.images.isNotEmpty
              ? PageView.builder(
                  controller: widget.controller,
                  itemCount: widget.images.length,
                  onPageChanged: (value) {
                    setState(() {
                      _activePage = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.file(
                      widget.images[index],
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
                      onPressed: widget.onAddImage,
                    ),
                  ),
                ),
        ),
        if (widget.images.isNotEmpty)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  widget.images.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: InkWell(
                      onTap: () {
                        widget.controller.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: _activePage == index
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

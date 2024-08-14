// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../widgets/ImagePlaceholder.dart';

class HotelImagesSection extends StatefulWidget {
  final List<String> imagePaths;

  const HotelImagesSection({super.key, required this.imagePaths});

  @override
  _HotelImagesSectionState createState() => _HotelImagesSectionState();
}

class _HotelImagesSectionState extends State<HotelImagesSection> {
  int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> _pages;
  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (_pageController.page == widget.imagePaths.length - 1) {
          _pageController.animateToPage(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        } else {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _pages = widget.imagePaths
        .map((path) => ImagePlaceholder(imagePath: path))
        .toList();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3.4,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            onPageChanged: (value) {
              setState(() {
                _activePage = value;
              });
            },
            itemBuilder: (context, index) {
              return _pages[index];
            },
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
                _pages.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(index,
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

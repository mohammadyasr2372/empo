// ignore_for_file: file_names, library_private_types_in_public_api, use_super_parameters, avoid_print, prefer_const_constructors

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../data/data_source/restaurnat_data_source/resturant_datasource.dart';
import '../../data/models/restaurant_model/getdetails_restorant/getinforestorant.dart';

class ImagesSection extends StatefulWidget {
  final DataGetinforestorant
      data; // Assuming DataGetinforestorant contains the necessary image data

  const ImagesSection({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _ImagesSectionState createState() => _ImagesSectionState();
}

class _ImagesSectionState extends State<ImagesSection> {
  int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> _pages;
  late Timer _timer;
  bool isLoading = true;
  String? errorMessage;
  ResturantDatasourceImpl resturantDatasource =
      ResturantDatasourceImpl(dio: Dio());
  Getinforestorant? inforestorant;

  @override
  void initState() {
    super.initState();
    fetchRestaurantImage(); // Fetch images when the widget initializes
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (_pageController.page == _pages.length - 1) {
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

  Future<void> fetchRestaurantImage() async {
    try {
      final getinfo =
          await resturantDatasource.getresturantdetails_datasourece();
      setState(() {
        inforestorant = getinfo;

        // Initialize the _pages list with images once the data is fetched
        _pages = inforestorant!.data!.restImage
            .map((image) => ImagePlaceholder(
                imagePath:
                    'http://localhost:3000/${image.url!.split('/').last}'))
            .toList();
        print(
            'http://localhost:3000/${inforestorant!.data!.restImage.first.url!.split('/').last}');

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching restaurant details: $e';
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3.4,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
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
// import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  final String? imagePath;

  const ImagePlaceholder({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imagePath!,
      fit: BoxFit.cover,
    );
  }
}

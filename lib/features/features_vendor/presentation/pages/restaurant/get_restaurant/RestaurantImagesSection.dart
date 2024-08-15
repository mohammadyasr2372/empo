import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/strings/constans.dart';
import '../../../../data/data_source/restaurnat_data_source/resturant_datasource.dart';
import '../../../../data/models/restaurant_model/getdetails_restorant/getinforestorant.dart';

class ImagesSectionRestorant extends StatefulWidget {
  final DataGetinforestorant
      data; // Assuming DataGetinforestorant contains the necessary image data

  const ImagesSectionRestorant({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _ImagesSectionRestorantState createState() => _ImagesSectionRestorantState();
}

class _ImagesSectionRestorantState extends State<ImagesSectionRestorant> {
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
                imagePath: '${BASE_URL}${image.url!.split('/').last}'))
            .toList();
        print(
            '$BASE_URL/${inforestorant!.data!.restImage.first.url!.split('/').last}');

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







// import 'dart:async';
// import 'package:flutter/material.dart';
// import '../../../widgets/ImagePlaceholder.dart';
// import '../../../widgets/widget_hotel/widget_get/ImagePlaceholder.dart';

// class RestaurantImagesSection extends StatefulWidget {
//   final List<String> imagePaths;

//   const RestaurantImagesSection({Key? key, required this.imagePaths})
//       : super(key: key);

//   @override
//   _RestaurantImagesSectionState createState() =>
//       _RestaurantImagesSectionState();
// }

// class _RestaurantImagesSectionState extends State<RestaurantImagesSection> {
//   int _activePage = 0;
//   final PageController _pageController = PageController(initialPage: 0);
//   late List<Widget> _pages;
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _pages = widget.imagePaths
//         .map((path) => ImagePlaceholder(imagePath: path))
//         .toList();
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(
//       const Duration(seconds: 3),
//       (timer) {
//         if (_pageController.page == widget.imagePaths.length - 1) {
//           _pageController.animateToPage(0,
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeIn);
//         } else {
//           _pageController.nextPage(
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeIn);
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         ClipRRect(
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(15),
//             bottomRight: Radius.circular(15),
//           ),
//           child: SizedBox(
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height / 3.4,
//             child: PageView.builder(
//               controller: _pageController,
//               itemCount: widget.imagePaths.length,
//               onPageChanged: (value) {
//                 setState(() {
//                   _activePage = value;
//                 });
//               },
//               itemBuilder: (context, index) {
//                 return _pages[index];
//               },
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 10,
//           left: 0,
//           right: 0,
//           child: Container(
//             color: Colors.transparent,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List<Widget>.generate(
//                 _pages.length,
//                 (index) => Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                   child: InkWell(
//                     onTap: () {
//                       _pageController.animateToPage(index,
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeIn);
//                     },
//                     child: CircleAvatar(
//                       radius: 4,
//                       backgroundColor: _activePage == index
//                           ? Colors.deepPurple
//                           : Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../core/strings/constans.dart';
import '../../../data/data_source/candiesshop_datasource/candiesShop_datasource.dart';
import '../../../data/models/candeisshop_model/getcandyShop_model.dart';

class ImagesSectionCandies extends StatefulWidget {
  final DatacandyshopModel
      data; // Assuming DataGetinforestorant contains the necessary image data

  const ImagesSectionCandies({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _ImagesSectionCandiesState createState() => _ImagesSectionCandiesState();
}

class _ImagesSectionCandiesState extends State<ImagesSectionCandies> {
  int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> _pages;
  late Timer _timer;
  bool isLoading = true;
  String? errorMessage;
  CandiesshopDatasourceImpl resturantDatasource =
      CandiesshopDatasourceImpl(dio: Dio());
  GetcandyshopModel? inforestorant;

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
      final getinfo = await resturantDatasource.getCandiesShop_datasourece();
      setState(() {
        inforestorant = getinfo;

        // Initialize the _pages list with images once the data is fetched
        _pages = inforestorant!.data!.candeImage
            .map((image) => ImagePlaceholder(
                imagePath: '${BASE_URL}${image.url!.split('/').last}'))
            .toList();
        print(
            '$BASE_URL/${inforestorant!.data!.candeImage.first.url!.split('/').last}');

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
      '${BASE_URL}${imagePath!.split('/').last}',
      fit: BoxFit.cover,
    );
  }
}
// class ImagesSectionCandies extends StatefulWidget {
//   final DatacandyshopModel data;

//   const ImagesSectionCandies({
//     Key? key,
//     required this.data,
//   }) : super(key: key);

//   @override
//   _ImagesSectionCandiesState createState() => _ImagesSectionCandiesState();
// }

// class _ImagesSectionCandiesState extends State<ImagesSectionCandies> {
//   int _activePage = 0;
//   final PageController _pageController = PageController(initialPage: 0);
//   late List<Widget> _pages;
//   late Timer _timer;
//   bool isLoading = true;
//   String? errorMessage;
//   final CandiesshopDatasourceImpl resturantDatasource =
//       CandiesshopDatasourceImpl(dio: Dio());
//   GetcandyshopModel? getCandyshop;

//   @override
//   void initState() {
//     super.initState();
//     fetchRestaurantImage();
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(
//       const Duration(seconds: 3),
//       (timer) {
//         if (_pageController.page == _pages.length - 1) {
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

//   Future<void> fetchRestaurantImage() async {
//     try {
//       final getInfo = await resturantDatasource.getCandiesShop_datasourece();
//       setState(() {
//         getCandyshop = getInfo;

//         _pages = getCandyshop!.data!.candeImage
//             .map((image) => ImagePlaceholder(
//                 imagePath:
//                     'http://localhost:3000/${image.url!.split('/').last}'))
//             .toList();

//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error fetching restaurant details: $e';
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (errorMessage != null) {
//       return Center(child: Text(errorMessage!));
//     }

//     return Stack(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height / 3.4,
//           child: PageView.builder(
//             controller: _pageController,
//             itemCount: _pages.length,
//             onPageChanged: (value) {
//               setState(() {
//                 _activePage = value;
//               });
//             },
//             itemBuilder: (context, index) {
//               return _pages[index];
//             },
//           ),
//         ),
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(_pages.length, (index) {
//               return Container(
//                 margin: const EdgeInsets.all(4),
//                 width: _activePage == index ? 10 : 8,
//                 height: _activePage == index ? 10 : 8,
//                 decoration: BoxDecoration(
//                   color: _activePage == index ? Colors.orange : Colors.grey,
//                   shape: BoxShape.circle,
//                 ),
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../data/data_source/restaurnat_data_source/resturant_datasource.dart';
import '../../../../data/models/restaurant_model/getdetails_restorant/getinforestorant.dart';
import '../../../widgets/BookingButton.dart';
import '../../Hall_Images_Section.dart';
import '../../Hall_Information_Section.dart';
import '../../Stars_hall.dart';
import 'Hospitality_Images_Section.dart';
import 'RestaurantImagesSection.dart';

class RestaurantPage extends StatefulWidget {
  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  bool isLoading = true;
  String? errorMessage;
  ResturantDatasourceImpl resturantDatasource = ResturantDatasourceImpl(dio: Dio());
  Getinforestorant? inforestorant;

  @override
  void initState() {
    super.initState();
    fetchRestaurantDetails();
  }

  Future<void> fetchRestaurantDetails() async {
    try {
      final getinfo = await resturantDatasource.getresturantdetails_datasourece();
      setState(() {
        inforestorant = getinfo;
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
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(errorMessage!)),
      );
    }

    // Assuming the data model for `Getinforestorant` has an accessible structure
    final restaurantData = inforestorant!.data;
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Displaying the fetched images
            ImagesSectionRestorant(data: restaurantData!,),
            // Hall Information Section
            // InformationSection(),  // You can pass relevant data to this widget if needed
            // Hospitality Images Section with prices
            HospitalityImagesSection(
              // imagePaths: restaurantData!.hospitalityImages!.map((image) => image.url).toList(),
              // prices: restaurantData.hospitalityPrices,
            ),
            // Booking Button
            BookingButton(onPressed: () {
              // Implement navigation to booking page
            }),
          ],
        ),
      ),
    );
  }
}


// // ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class GetRestaurant extends StatefulWidget {
//   const GetRestaurant({Key? key}) : super(key: key);

//   @override
//   _GetRestaurantState createState() => _GetRestaurantState();
// }

// final List<String> imagePaths = [
//   'assets/images/photo1.jpg',
//   'assets/images/photo2.jpg',
//   'assets/images/photo3.jpg',
//   'assets/images/photo4.jpg',
//   'assets/images/photo5.jpg',
// ];

// final List<String> hospitalityImagePaths = [
//   'assets/images/photo1.jpg',
//   'assets/images/photo2.jpg',
//   'assets/images/photo3.jpg',
// ];

// final List<int> hospitalityPrices = [
//   100, // Price for photo1.jpg
//   150, // Price for photo2.jpg
//   200, // Price for photo3.jpg
// ];

// class _GetRestaurantState extends State<GetRestaurant> {
//   int _activePage = 0;
//   final PageController _pageController = PageController(initialPage: 0);
//   final PageController _hospitalityPageController =
//       PageController(initialPage: 0, viewportFraction: 0.8);
//   late List<Widget> _pages;
//   late Timer _timer;
//   int bookedPersons = 50;
//   final int minPersons = 50;
//   final int maxCapacity = 200;
//   final int pricePerPerson = 2500;
//   final int bookingPrice = 500000;

//   @override
//   void initState() {
//     super.initState();
//     _pages = List.generate(
//       imagePaths.length,
//       (index) => ImagePlaceholder(imagePath: imagePaths[index]),
//     );
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(
//       const Duration(seconds: 3),
//       (timer) {
//         if (_pageController.page == imagePaths.length - 1) {
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
//     _pageController.dispose(); // تأكد من التخلص من PageController
//     _hospitalityPageController.dispose(); // تأكد من التخلص من PageController
//     super.dispose();
//   }

//   void _navigateToBookingPage(BuildContext context) {
//     // Navigate to booking page (implement this function according to your navigation logic)
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   height: MediaQuery.of(context).size.height / 3.4,
//                   child: PageView.builder(
//                     controller: _pageController,
//                     itemCount: imagePaths.length,
//                     onPageChanged: (value) {
//                       setState(() {
//                         _activePage = value;
//                       });
//                     },
//                     itemBuilder: (context, index) {
//                       return _pages[index];
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 10,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     color: Colors.transparent,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List<Widget>.generate(
//                         _pages.length,
//                         (index) => Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                           child: InkWell(
//                             onTap: () {
//                               _pageController.animateToPage(index,
//                                   duration: const Duration(milliseconds: 300),
//                                   curve: Curves.easeIn);
//                             },
//                             child: CircleAvatar(
//                               radius: 4,
//                               backgroundColor: _activePage == index
//                                   ? Colors.deepPurple
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 15),
//             const Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 child: Text(
//                   'Restaurant Name',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Row(
//                 children: [
//                   RatingBar.builder(
//                     initialRating: 0,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
//                     itemBuilder: (context, _) => const Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (rating) {
//                       print('rating $rating');
//                     },
//                   ),
//                   const SizedBox(width: 5),
//                   const Text('4.5 (200 Reviews)', style: TextStyle(fontSize: 16)),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 50),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Share.share("Check out this awesome restaurant!!!");
//                     },
//                     child: const CircleAvatar(
//                       radius: 25,
//                       child: Icon(Icons.share),
//                     ),
//                   ),
//                   const CircleAvatar(
//                     radius: 25,
//                     child: Icon(Icons.location_on),
//                   ),
//                   const CircleAvatar(
//                     radius: 25,
//                     child: Icon(Icons.bookmark_border),
//                   ),
//                   const CircleAvatar(
//                     radius: 25,
//                     child: Icon(Icons.favorite_border_sharp),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 15),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.start,
//             //     children: [
//             //       Text(
//             //         'Address: 123 Main Street, City, Country',
//             //         style: const TextStyle(
//             //             fontWeight: FontWeight.bold, fontSize: 16),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             Row(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8),
//                   child: Text(
//                     'Capacity',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 const Icon(Icons.group, size: 30),
//                 Text(
//                   '= $maxCapacity ',
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 15),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             // Container(
//             //   height: 200,
//             //   color: Colors.grey[300],
//             //   child: Center(child: Text('Map Placeholder')),
//             // ),
//             const SizedBox(height: 10),
//             const Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'Menu',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 1),
//             SizedBox(
//               height: 250,
//               child: PageView.builder(
//                 controller: _hospitalityPageController,
//                 itemCount: hospitalityImagePaths.length,
//                 itemBuilder: (context, index) {
//                   return hospitalityCarouselView(index);
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => _navigateToBookingPage(context),
//                   child: const Text('Make a Reservation',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.white)),
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     backgroundColor: Colors.deepPurple,
//                     textStyle: const TextStyle(fontSize: 18),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget hospitalityCarouselView(int index) {
//     return AnimatedBuilder(
//       animation: _hospitalityPageController,
//       builder: (context, child) {
//         double value = 0.0;
//         if (_hospitalityPageController.position.haveDimensions) {
//           value = index.toDouble() - (_hospitalityPageController.page ?? 0);
//           value = (value * 0.038).clamp(-1, 1);
//         }
//         return Transform.rotate(
//           angle: pi * value,
//           child: hospitalityCarouselCard(
//             hospitalityImagePaths[index],
//             hospitalityPrices[index],
//           ),
//         );
//       },
//     );
//   }

//   Widget hospitalityCarouselCard(String imagePath, int price) {
//     return Column(
//       children: <Widget>[
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     image: DecorationImage(
//                       image: AssetImage(imagePath),
//                       fit: BoxFit.cover,
//                     ),
//                     boxShadow: const [
//                       BoxShadow(
//                         offset: Offset(0, 4),
//                         blurRadius: 4,
//                         color: Colors.black26,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 10,
//                   right: 10,
//                   child: Container(
//                     color: Colors.black54,
//                     padding: const EdgeInsets.all(5),
//                     child: Text(
//                       '\$$price',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ImagePlaceholder extends StatelessWidget {
//   final String imagePath;

//   const ImagePlaceholder({Key? key, required this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       imagePath,
//       fit: BoxFit.cover,
//     );
//   }
// }

// class HospitalityCarouselCard extends StatelessWidget {
//   final String imagePath;
//   final int price;

//   const HospitalityCarouselCard({
//     Key? key,
//     required this.imagePath,
//     required this.price,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               image: DecorationImage(
//                 image: AssetImage(imagePath),
//                 fit: BoxFit.cover,
//               ),
//               boxShadow: const [
//                 BoxShadow(
//                   offset: Offset(0, 4),
//                   blurRadius: 4,
//                   color: Colors.black26,
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             right: 10,
//             child: Container(
//               color: Colors.black54,
//               padding: const EdgeInsets.all(5),
//               child: Text(
//                 '\$$price',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ImagePlaceholder extends StatelessWidget {
//   final String imagePath;

//   const ImagePlaceholder({Key? key, required this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       imagePath,
//       fit: BoxFit.cover,
//     );
//   }
// }

// class BookingButton extends StatelessWidget {
//   final VoidCallback onPressed;

//   const BookingButton({Key? key, required this.onPressed}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         width: double.infinity,
//         child: ElevatedButton(
//           onPressed: onPressed,
//           child: const Text('Make a Reservation',
//               style:
//                   TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(vertical: 15),
//             backgroundColor: Colors.deepPurple,
//             textStyle: const TextStyle(fontSize: 18),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

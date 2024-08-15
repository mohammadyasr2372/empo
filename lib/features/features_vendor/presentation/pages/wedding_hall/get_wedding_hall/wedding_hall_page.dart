// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:async';
// import 'dart:math';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:share_plus/share_plus.dart';

// class GET_WeddingHall extends StatefulWidget {
//   final String id;
//   final String name;
//   const GET_WeddingHall({
//     Key? key,
//     required this.id,
//     required this.name,
//   }) : super(key: key);

//   @override
//   _GET_WeddingHallState createState() => _GET_WeddingHallState();
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
//   'assets/images/photo1.jpg',
//   'assets/images/photo1.jpg',
// ];

// class _GET_WeddingHallState extends State<GET_WeddingHall> {
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
//           _pageController
//               .nextPage(
//                   duration: const Duration(milliseconds: 500),
//                   curve: Curves.easeIn)
//               .then((_) {});
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   Dio dio = Dio(); // Create Dio instance

//   Future<void> getImageFromServer(String imageUrl) async {
//     try {
//       Response response = await dio.get(imageUrl,
//           options: Options(responseType: ResponseType.bytes));
//       if (response.statusCode == 200) {
//         setState(() {
//           _pages.add(
//             Image.memory(
//               response.data,
//               fit: BoxFit.cover,
//             ),
//           );
//         });
//       } else {
//         throw Exception('Failed to load image');
//       }
//     } catch (e) {
//       print('Error fetching image: $e');
//     }
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
//             const SizedBox(height: 9),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 child: Text(
//                   widget.name,
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 5),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Row(
//                 children: [
//                   RatingBar.builder(
//                     initialRating: 0,
//                     minRating: 1.5,
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
//                   Text('4.5 (200 Reviews)', style: TextStyle(fontSize: 16)),
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
//                       Share.share("Check out this awesome package!!!");
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
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Booking Price: $bookingPrice',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const SizedBox(width: 60),
//                   const Icon(Icons.person, size: 30),
//                   Text(
//                     '= $pricePerPerson per person',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 15),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Capacity',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const SizedBox(width: 10),
//                   const Icon(Icons.group, size: 30),
//                   Text(
//                     '= $maxCapacity ',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 15),
//                   ),
//                   const SizedBox(width: 55),
//                   const Text(
//                     'Persons to Book',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const Icon(Icons.person, size: 30),
//                   Text(
//                     '= $minPersons',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 15),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'Hospitality Images',
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
//                   child: const Text('Proceed to Booking',
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
//           child: hospitalityCarouselCard(hospitalityImagePaths[index]),
//         );
//       },
//     );
//   }

//   Widget hospitalityCarouselCard(String imagePath) {
//     return Column(
//       children: <Widget>[
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   image: DecorationImage(
//                       image: AssetImage(imagePath), fit: BoxFit.cover),
//                   boxShadow: const [
//                     BoxShadow(
//                         offset: Offset(0, 4),
//                         blurRadius: 4,
//                         color: Colors.black26)
//                   ]),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ImagePlaceholder extends StatelessWidget {
//   final String? imagePath;

//   const ImagePlaceholder({Key? key, this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       imagePath!,
//       fit: BoxFit.cover,
//     );
//   }
// }

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../data/data_source/wedding_data_source/weddingHallDataSource.dart';
import '../../../../data/models/wedding_hall_model/get/report_get.dart';
import '../../../widgets/BookingButton.dart';
import '../../../widgets/ImagePlaceholder.dart';
import '../../Stars_hall.dart';
import '../../Users/booked/BookedUser/booked_weddinghall.dart';
import 'Hospitality_Images_Section.dart';

class WeddingHallPage extends StatefulWidget {
  WeddingHallPage({Key? key}) : super(key: key);

  @override
  State<WeddingHallPage> createState() => _WeddingHallPageState();
}

class _WeddingHallPageState extends State<WeddingHallPage> {
  bool isLoading = true;
  String? errorMessage;
  WeddinghalldatasourceImpl Weddinghalldatasource =
      WeddinghalldatasourceImpl(dio: Dio());
  msg_Get_Wedd_hal? msg_GetWedding;

  @override
  void initState() {
    super.initState();
    fetchWeddingDetails();
  }

  Future<void> fetchWeddingDetails() async {
    try {
      final getinfo =
          await Weddinghalldatasource.getweddingdetailsdatasourece();
      setState(() {
        msg_GetWedding = getinfo;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching wedding details: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImagesSectionWedding(data: msg_GetWedding!.dataWidding!),
            // InformationSection(),
            HospitalityImagesSection(
              imagePaths: msg_GetWedding!.dataWidding!.imagehospit
                  .map((image) => image.url!)
                  .toList(),
              bookingPrice: msg_GetWedding!.dataWidding!.bookprice,
              pricePerPerson: msg_GetWedding!.dataWidding!.personbook,
              maxCapacity: msg_GetWedding!.dataWidding!.capacity,
              minPersons: msg_GetWedding!.dataWidding!.capacityMin,
            ),
            BookingButton(onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MyAppp1()),
              // );
            }),
          ],
        ),
      ),
    );
  }
}

class ImagesSectionWedding extends StatefulWidget {
  final DataWidding data;

  const ImagesSectionWedding({Key? key, required this.data}) : super(key: key);

  @override
  _ImagesSectionWeddingState createState() => _ImagesSectionWeddingState();
}

class _ImagesSectionWeddingState extends State<ImagesSectionWedding> {
  int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> _pages;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pages = widget.data.imagewids
        .map((image) => ImagePlaceholderWedding(imagePath: image.url!))
        .toList();
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
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../domain/entities/wedding_hall_entity/get_entity/getwedding.dart';
// import '../../../bloc/wedding_hall_bloc/wedding_bloc.dart';
// import '../../../widgets/BookingButton.dart';
// import '../../Hall_Images_Section.dart';
// import '../../Stars_hall.dart';
// import 'Hospitality_Images_Section.dart';

// class WeddingHallPage extends StatelessWidget {
//   WeddingHallPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<WeddingBloc, WeddingState>(
//       builder: (context, state) {
//         if (state is LoadedWeddingState) {
//           final weddingHall = state.getweddEntity;
//           return Scaffold(
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   ImagesSection(
//                       imagePaths: getImagePaths(weddingHall.dataWidding)),
//                       InformationSection(),
//                   // StarsHall(
//                   //   name: weddingHall.dataWidding!.id ??
//                   //       '', // Adjust this based on your requirements
//                   //   customerId: '665efefe9b89ab3f4a632ad0',
//                   //   authToken:
//                   //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NWVmZjQ0OWI4OWFiM2Y0YTYzMmFkOCIsImlzX3VzZXIiOnRydWUsImlhdCI6MTcxNzUwMTc2NCwiZXhwIjoxNzE3NTA4OTY0fQ.LKljxc00fUV86HB85xw6x3z4DI1PjrKTBzxBnWwLXuw',
//                   // ),
//                   HospitalityImagesSection(
//                     imagePaths: weddingHall.dataWidding!.imagehospit
//                         .map((image) => image.toString())
//                         .toList(),
//                     bookingPrice: weddingHall.dataWidding!.bookprice,
//                     pricePerPerson: weddingHall.dataWidding!.personbook,
//                     maxCapacity: weddingHall.dataWidding!.pricetotel,
//                     minPersons: weddingHall.dataWidding!
//                         .capacityMin, // Assuming imagehospit is List<dynamic>
//                   ),
//                   BookingButton(onPressed: () {
//                     // Implement navigation to booking page
//                   }),
//                 ],
//               ),
//             ),
//           );
//         } else if (state is ErrorWeddingState) {
//           return Center(
//               child:
//                   Text('Failed to load wedding hall data: ${state.message}'));
//         }

//         return Container();
//       },
//     );
//   }

//   List<String> getImagePaths(GetDataWiddingEntity? dataWidding) {
//     if (dataWidding != null && dataWidding.imagewids.isNotEmpty) {
//       return dataWidding.imagewids.map((image) => image.id ?? '').toList();
//     } else {
//       return [];
//     }
//   }
// }

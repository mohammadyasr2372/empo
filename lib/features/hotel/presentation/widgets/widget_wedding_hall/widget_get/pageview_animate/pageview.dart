// import 'package:flutter/material.dart';


// import '../../../../../../models/model_wedding_hall.dart';
// import 'room_carousel_view.dart';

// class Pageview extends StatelessWidget {
//   final WeddingHall Wedding_hall;

//   Pageview({super.key, required this.Wedding_hall});
//   final PageController _hospitalityPageController =
//       PageController(initialPage: 0, viewportFraction: 0.8);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 250,
//       child: PageView.builder(
//         controller: _hospitalityPageController,
//         itemCount: Wedding_hall.imagePaths.length,
//         itemBuilder: (context, index) {
//           return HospitalityCarouselView(
//             imagePaths: Wedding_hall.imagePaths,
//             pageController: _hospitalityPageController,
//             index: index,
//           );
//         },
//       ),
//     );
//   }
// }

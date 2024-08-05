// import 'package:flutter/material.dart';
// import '../../../../../domain/entities/room_entity.dart';
// import 'room_carousel_view.dart';

// class Pageviewhotel extends StatelessWidget {
//   final Room room;
//   Pageviewhotel({
//     super.key,
//     required this.room,
//   });
//   final PageController _roomPageController =
//       PageController(initialPage: 0, viewportFraction: 0.8);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: 230,
//         child: PageView.builder(
//           controller: _roomPageController,
//           itemCount: 1,
//           itemBuilder: (context, index) {
//             return RoomCarouselView(
//               imagePath: room.image_room!,
//               controller: _roomPageController,
//               index: index,
//             );
//           },
//         ));
//   }
// }

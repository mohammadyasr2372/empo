// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, non_constant_identifier_names

// import 'package:flutter/material.dart';
// import '../../../../domain/entities/hotel_entity.dart';
// import '../../../../domain/entities/room_entity.dart';
// import '../../../widgets/BookingButton.dart';
// import '../../../widgets/widget_hotel/widget_get/RoomSection.dart';
// import 'HotelImagesSection.dart';
// import 'InformationSection.dart';

// class HotelPage extends StatefulWidget {
//   const HotelPage({super.key});

//   @override
//   _HotelPageState createState() => _HotelPageState();
// }

// class _HotelPageState extends State<HotelPage> {
//   late Hotel hotel;
//   final List<String> vipRoomImages = [
//     'assets/images/photo4.jpg',
//     'assets/images/photo4.jpg',
//     'assets/images/photo4.jpg',
//   ];

//   final List<String> deluxeRoomImages = [
//     'assets/images/photo3.jpg',
//     'assets/images/photo3.jpg',
//     'assets/images/photo3.jpg',
//   ];

//   final List<String> superDeluxeRoomImages = [
//     'assets/images/photo2.jpg',
//     'assets/images/photo2.jpg',
//     'assets/images/photo2.jpg',
//   ];
//   final List<String> hotel_Hall = [
//     'assets/images/photo2.jpg',
//     'assets/images/photo2.jpg',
//     'assets/images/photo2.jpg',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the hotel data
//     hotel = Hotel(
//       name: 'Muhammad',
//       image: [
//         'assets/image/photo.jpg',
//         'assets/image/photo.jpg',
//         'assets/image/photo.jpg',
//         'assets/image/photo.jpg',
//         'assets/image/photo.jpg',
//       ],
//       rooms: [
//         Room(
//           name_room: 'VIP Rooms',
//           image_room: 'assets/image/photo.jpg',
//           price_day: '15000',
//           room_type: 'ewsd',
//         ),
//         Room(
//           name_room: 'Deluxe Rooms',
//           image_room: 'assets/image/photo.jpg',
//           price_day: '10000',
//           room_type: 'ewsd',
//         ),
//         Room(
//           name_room: 'Super Deluxe Rooms',
//           image_room: 'assets/image/photo.jpg',
//           price_day: '8000',
//           room_type: 'ewsd',
//         ),
//         Room(
//           name_room: 'hotel_Hall',
//           image_room: 'assets/image/photo.jpg',
//           price_day: '80090',
//           room_type: 'ewsd',
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             HotelImagesSection(
//               imagePaths: hotel.image!,
//             ),
//             HotelInformationSection(
//               name: hotel.name!,
//             ),
//             ...hotel.rooms!.map((room) => RoomSection(room: room)),
//             BookingButton(
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

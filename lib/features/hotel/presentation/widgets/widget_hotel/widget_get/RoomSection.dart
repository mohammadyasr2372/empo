// ignore_for_file: file_names, use_super_parameters

import 'package:flutter/material.dart';

import '../../../../domain/entities/room_entity.dart';
import 'pageview_animate/pageview.dart';

class RoomSection extends StatelessWidget {
  final Room room;

  const RoomSection({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            room.name_room!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Pageviewhotel(
            room: room,
          ),
          // SizedBox(
          //   height: 230,
          //   child: PageView.builder(
          //     controller: _roomPageController,
          //     itemCount: room.images.length,
          //     itemBuilder: (context, index) {
          //       return RoomCarouselView(
          //         imagePath: room.images[index],
          //         controller: _roomPageController,
          //         index: index,
          //       );
          //     },
          //   ),
          // ),
          const SizedBox(height: 10),
          Text(
            'Price per Night: ${room.price_day}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            'Available Rooms: ${room.room_type}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          const Divider(),
        ],
      ),
    );
  }
}

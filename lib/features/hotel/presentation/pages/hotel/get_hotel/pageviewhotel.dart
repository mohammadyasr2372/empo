// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print

import 'package:flutter/material.dart';
import 'package:party/features/hotel/domain/entities/room_type.dart';
import 'package:party/features/hotel/presentation/widgets/widget_hotel/widget_get/pageview_animate/room_carousel_view.dart';

import 'room_get_details_page.dart';

class Pageviewhotel extends StatelessWidget {
  final RoomType roomType;
  Pageviewhotel({
    super.key,
    required this.roomType,
  });
  final PageController _roomPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: PageView.builder(
        controller: _roomPageController,
        itemCount: roomType.images.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(roomType.images[index].id);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoomGetDetailsPage(
                            id: roomType.images[index].id,
                          )));
            },
            child: RoomCarouselView(
              imagePath: roomType.images[index].image,
              controller: _roomPageController,
              index: index,
            ),
          );
        },
      ),
    );
  }
}

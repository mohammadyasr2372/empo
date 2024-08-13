// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print

import 'package:flutter/material.dart';
import 'package:party/features/hotel/data/model/get_widd_model.dart';
import 'package:party/features/hotel/presentation/widgets/widget_hotel/widget_get/pageview_animate/room_carousel_view.dart';

class PageviewhotelWidd extends StatelessWidget {
  final GetWiddModel getWiddModel;
  PageviewhotelWidd({
    super.key,
    required this.getWiddModel,
  });
  final PageController _roomPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: PageView.builder(
        controller: _roomPageController,
        itemCount: getWiddModel.imagewids_hotal.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(getWiddModel.bookprice);
            },
            child: RoomCarouselView(
              imagePath: getWiddModel.imagewids_hotal[index].url,
              controller: _roomPageController,
              index: index,
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:party/features/features_vendor/presentation/widgets/widget_wedding_hall/widget_get/pageview_animate/room_carousel_view.dart';

import '../../../models/model_wedding_hall.dart';

class Pageview extends StatelessWidget {
  final WeddingHall Wedding_hall;

  Pageview({super.key, required this.Wedding_hall});
  final PageController _hospitalityPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        controller: _hospitalityPageController,
        itemCount: Wedding_hall.imagePaths.length,
        itemBuilder: (context, index) {
          return HospitalityCarouselView(
            imagePath: Wedding_hall.imagePaths[index],
            index: index,
            controller: _hospitalityPageController,
          );
        },
      ),
    );
  }
}

// ignore_for_file: unused_import, duplicate_import

import 'dart:math';

import 'package:flutter/material.dart';
import 'wedding_hall_page.dart';

import 'package:flutter/material.dart';
import '../../../widgets/widget_wedding_hall/widget_get/pageview_animate/room_carousel_view.dart';

class HospitalityImagesSection extends StatefulWidget {
  final List<String> imagePaths;
  final int? bookingPrice;
  final int? pricePerPerson;
  final int? maxCapacity;
  final int? minPersons;

  const HospitalityImagesSection({
    super.key,
    required this.imagePaths,
    required this.bookingPrice,
    required this.pricePerPerson,
    required this.maxCapacity,
    required this.minPersons,
  });

  @override
  _HospitalityImagesSectionState createState() =>
      _HospitalityImagesSectionState();
}

class _HospitalityImagesSectionState extends State<HospitalityImagesSection> {
  final PageController _hospitalityPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Booking Price: ${widget.bookingPrice!}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 50),
              const Icon(Icons.person, size: 30),
              Text(
                '= ${widget.pricePerPerson} per person',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Capacity',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.group, size: 30),
              Text(
                '= ${widget.maxCapacity}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(width: 40),
              const Text(
                'Persons to Book',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Icon(Icons.person, size: 30),
              Text(
                '= ${widget.minPersons}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Hospitality Images',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _hospitalityPageController,
            itemCount: widget.imagePaths.length,
            itemBuilder: (context, index) {
              return HospitalityCarouselViewWedding(
                imagePath: widget.imagePaths[index],
                controller: _hospitalityPageController,
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}

class HospitalityCarouselViewWedding extends StatelessWidget {
  final String imagePath;
  final PageController controller;
  final int index;

  const HospitalityCarouselViewWedding({
    super.key,
    required this.imagePath,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 0.0;
        if (controller.position.haveDimensions) {
          value = index.toDouble() - (controller.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
        }
        return Transform.rotate(
          angle: pi * value,
          child: HospitalityCarouselCardWedding(imagePath: imagePath),
        );
      },
    );
  }
}

class HospitalityCarouselCardWedding extends StatelessWidget {
  final String imagePath;

  const HospitalityCarouselCardWedding({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(
                      'http://localhost:3000/${imagePath.split('/').last}'),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: Colors.black26,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

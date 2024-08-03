// ignore_for_file: use_super_parameters, prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:share_plus/share_plus.dart';

class HotelInformationSection extends StatelessWidget {
  final String name;

  const HotelInformationSection({Key? key, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 9),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              // RatingBar.builder(
              //   initialRating: 1,
              //   minRating: 1,
              //   direction: Axis.horizontal,
              //   allowHalfRating: true,
              //   itemCount: 5,
              //   itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
              //   itemBuilder: (context, _) => const Icon(
              //     Icons.star,
              //     color: Colors.amber,
              //   ),
              //   onRatingUpdate: (rating) {
              //     print('rating $rating');
              //   },
              // ),
              const SizedBox(width: 5),
              Text('4.5 (200 Reviews)', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // Share.share("Check out this awesome hotel!!!");
                },
                child: const CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.share),
                ),
              ),
              const CircleAvatar(
                radius: 25,
                child: Icon(Icons.location_on),
              ),
              const CircleAvatar(
                radius: 25,
                child: Icon(Icons.bookmark_border),
              ),
              const CircleAvatar(
                radius: 25,
                child: Icon(Icons.favorite_border_sharp),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

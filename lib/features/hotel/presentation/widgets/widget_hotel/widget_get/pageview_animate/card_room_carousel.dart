// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:party/core/strings/constans.dart';

class RoomCarouselCard extends StatelessWidget {
  final String imagePath;

  const RoomCarouselCard({Key? key, required this.imagePath}) : super(key: key);

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
                  image: NetworkImage('$BASE_URL/${imagePath.split('/').last}'),
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

import 'dart:developer';

import 'package:flutter/material.dart';

class MenuCarouselCard extends StatelessWidget {
  final String imagePath;

  const MenuCarouselCard({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage('http://localhost:3000/${imagePath.split('/').last}'),
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
    );
  }
}

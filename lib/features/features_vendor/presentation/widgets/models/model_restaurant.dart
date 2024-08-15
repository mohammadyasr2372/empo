// ignore_for_file: non_constant_identifier_names

import 'dart:io';

class Restaurant {
  final String name;
  final List<String> imagePaths;
  final List<String> hospitalityImages;
  final List<int> hospitalityPrices;

  Restaurant({
    required this.name,
    required this.imagePaths,
    required this.hospitalityImages,
    required this.hospitalityPrices,
  });
}

class AddRestaurant {
  final int all_table;
  final int number_booked;
  final int price_table;
  final String date;
  final List<File> rest_image;
  AddRestaurant({
    required this.all_table,
    required this.number_booked,
    required this.price_table,
    required this.date,
    required this.rest_image,
  });
}

class MenuImage {
  final File image;
  double price;
  String name;
  MenuImage({
    required this.image,
    required this.price,
    required this.name,
  });
}

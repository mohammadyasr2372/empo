// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:io';

class PostInfoLocationShopper {
  final String Name;
  final String city;
  final num location1;
  final num location2;
  final File image;
  PostInfoLocationShopper({
    required this.Name,
    required this.city,
    required this.location1,
    required this.location2,
    required this.image,
  });
}

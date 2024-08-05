// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, non_constant_identifier_names
import 'dart:io';

import 'package:equatable/equatable.dart';

class WiddHotelPost extends Equatable {
  String bookprice;
  String capacity;
  String personbook;
  String capacityMin;
  List<File> imagewids_hotal;
  WiddHotelPost({
    required this.bookprice,
    required this.capacity,
    required this.personbook,
    required this.capacityMin,
    required this.imagewids_hotal,
  });

  @override
  List<Object> get props {
    return [
      bookprice,
      capacity,
      personbook,
      capacityMin,
      imagewids_hotal,
    ];
  }
}

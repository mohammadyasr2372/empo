// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, non_constant_identifier_names
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

class WiddHotelPost extends Equatable {
  final String hotelId;
  final String bookprice;
  final String capacity;
  final String personbook;
  final String capacityMin;
  final List<File> imagewids_hotal;
  const WiddHotelPost({
    required this.hotelId,
    required this.bookprice,
    required this.capacity,
    required this.personbook,
    required this.capacityMin,
    required this.imagewids_hotal,
  });

  WiddHotelPost copyWith({
    String? hotelId,
    String? bookprice,
    String? capacity,
    String? personbook,
    String? capacityMin,
    List<File>? imagewids_hotal,
  }) {
    return WiddHotelPost(
      hotelId: hotelId ?? this.hotelId,
      bookprice: bookprice ?? this.bookprice,
      capacity: capacity ?? this.capacity,
      personbook: personbook ?? this.personbook,
      capacityMin: capacityMin ?? this.capacityMin,
      imagewids_hotal: imagewids_hotal ?? this.imagewids_hotal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hotelId': hotelId,
      'bookprice': bookprice,
      'capacity': capacity,
      'personbook': personbook,
      'capacityMin': capacityMin,
      'imagewids_hotal': imagewids_hotal,
    };
  }

  factory WiddHotelPost.fromMap(Map<String, dynamic> map) {
    return WiddHotelPost(
        hotelId: map['hotelId'] as String,
        bookprice: map['bookprice'] as String,
        capacity: map['capacity'] as String,
        personbook: map['personbook'] as String,
        capacityMin: map['capacityMin'] as String,
        imagewids_hotal: List<File>.from(
          (map['imagewids_hotal'] as List<File>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory WiddHotelPost.fromJson(String source) =>
      WiddHotelPost.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      hotelId,
      bookprice,
      capacity,
      personbook,
      capacityMin,
      imagewids_hotal,
    ];
  }
}

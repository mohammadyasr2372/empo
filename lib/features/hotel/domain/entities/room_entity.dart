// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_mobileentifier_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String? hotelId;
  final String? name_room;
  final String? price_day;
  final String? room_type;
  final List<File>? image_room;
  const Room({
    this.hotelId,
    this.name_room,
    this.price_day,
    this.room_type,
    this.image_room,
  });

  @override
  List<Object?> get props {
    return [
      hotelId,
      name_room,
      price_day,
      room_type,
      image_room,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hotelId': hotelId,
      'name_room': name_room,
      'price_day': price_day,
      'room_type': room_type,
      'image_room': image_room,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      hotelId: map['hotelId'] != null ? map['hotelId'] as String : null,
      name_room: map['name_room'] != null ? map['name_room'] as String : null,
      price_day: map['price_day'] != null ? map['price_day'] as String : null,
      room_type: map['room_type'] != null ? map['room_type'] as String : null,
      image_room: map['image'] != null
          ? List<File>.from((map['image'] as List<File>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);
}

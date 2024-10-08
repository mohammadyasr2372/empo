// ignore_for_file: non_constant_identifier_names, use_super_parameters

import 'dart:convert';
import 'dart:io';

import '../../domain/entities/room_entity.dart';

class RoomModel extends Room {
  const RoomModel({
    String? hotelId,
    String? name_room,
    String? price_day,
    String? room_type,
    List<File>? image_room,
  }) : super(
          hotelId: hotelId,
          name_room: name_room,
          price_day: price_day,
          room_type: room_type,
          image_room: image_room,
        );

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hotelId': hotelId,
      'name_room': name_room,
      'price_day': price_day,
      'room_type': room_type,
      'image_room': image_room,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      hotelId: map['hotelId'] != null ? map['hotelId'] as String : null,
      name_room: map['name_room'] != null ? map['name_room'] as String : null,
      price_day: map['price_day'] != null ? map['price_day'] as String : null,
      room_type: map['room_type'] != null ? map['room_type'] as String : null,
      image_room: map['image'] != null
          ? List<File>.from((map['image'] as List<File>))
          : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

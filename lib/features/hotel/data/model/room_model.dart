// ignore_for_file: non_constant_identifier_names, use_super_parameters

import 'dart:convert';

import '../../domain/entities/room_entity.dart';

class RoomModel extends Room {
  const RoomModel({
    String? hotelId,
    String? name_room,
    String? price_day,
    String? room_type,
    String? image,
  }) : super(
          hotelId: hotelId,
          name_room: name_room,
          price_day: price_day,
          room_type: room_type,
          image: image,
        );

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hotelId': hotelId,
      'name_room': name_room,
      'price_day': price_day,
      'room_type': room_type,
      'image': image,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      hotelId: map['hotelId'] != null ? map['hotelId'] as String : null,
      name_room: map['name_room'] != null ? map['name_room'] as String : null,
      price_day: map['price_day'] != null ? map['price_day'] as String : null,
      room_type: map['room_type'] != null ? map['room_type'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

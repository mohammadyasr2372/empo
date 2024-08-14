// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:party/features/hotel/data/model/image_net.dart';

class RoomGet {
  final String id;
  final String name_room;
  final num price_day;
  final List<ImageNet> image_room;
  final String room_type;
  RoomGet({
    required this.id,
    required this.name_room,
    required this.price_day,
    required this.image_room,
    required this.room_type,
  });

  RoomGet copyWith({
    String? id,
    String? name_room,
    num? price_day,
    List<ImageNet>? image_room,
    String? room_type,
  }) {
    return RoomGet(
      id: id ?? this.id,
      name_room: name_room ?? this.name_room,
      price_day: price_day ?? this.price_day,
      image_room: image_room ?? this.image_room,
      room_type: room_type ?? this.room_type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name_room': name_room,
      'price_day': price_day,
      'image_room': image_room.map((x) => x.toMap()).toList(),
      'room_type': room_type,
    };
  }

  factory RoomGet.fromMap(Map<String, dynamic> map) {
    return RoomGet(
      id: map['_id'] as String,
      name_room: map['name_room'] as String,
      price_day: map['price_day'] as num,
      image_room: List<ImageNet>.from(
        (map['image_room'] as List<dynamic>).map<ImageNet>(
          (x) => ImageNet.fromMap(x as Map<String, dynamic>),
        ),
      ),
      room_type: map['room_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomGet.fromJson(String source) =>
      RoomGet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomGet(id: $id, name_room: $name_room, price_day: $price_day, image_room: $image_room, room_type: $room_type)';
  }

  @override
  bool operator ==(covariant RoomGet other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name_room == name_room &&
        other.price_day == price_day &&
        listEquals(other.image_room, image_room) &&
        other.room_type == room_type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name_room.hashCode ^
        price_day.hashCode ^
        image_room.hashCode ^
        room_type.hashCode;
  }
}

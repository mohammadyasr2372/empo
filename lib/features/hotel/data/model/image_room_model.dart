// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:party/features/hotel/data/model/image_net.dart';

class GetDataImageRoom {
  final List<ImageRoomModel> imageRoom;
  final num counter_RoomsuperDelocs;
  GetDataImageRoom({
    required this.imageRoom,
    required this.counter_RoomsuperDelocs,
  });

  GetDataImageRoom copyWith({
    List<ImageRoomModel>? imageRoom,
    num? counter_RoomsuperDelocs,
  }) {
    return GetDataImageRoom(
      imageRoom: imageRoom ?? this.imageRoom,
      counter_RoomsuperDelocs:
          counter_RoomsuperDelocs ?? this.counter_RoomsuperDelocs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageRoom': imageRoom.map((x) => x.toMap()).toList(),
      'counter_RoomsuperDelocs': counter_RoomsuperDelocs,
    };
  }

  factory GetDataImageRoom.fromMap(Map<String, dynamic> map) {
    return GetDataImageRoom(
      imageRoom: List<ImageRoomModel>.from(
        (map['imageRoom'] as List<dynamic>).map<ImageRoomModel>(
          (x) => ImageRoomModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      counter_RoomsuperDelocs: map['counter_RoomsuperDelocs'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetDataImageRoom.fromJson(String source) =>
      GetDataImageRoom.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GetDataImageRoom(imageRoom: $imageRoom, counter_RoomsuperDelocs: $counter_RoomsuperDelocs)';

  @override
  bool operator ==(covariant GetDataImageRoom other) {
    if (identical(this, other)) return true;

    return listEquals(other.imageRoom, imageRoom) &&
        other.counter_RoomsuperDelocs == counter_RoomsuperDelocs;
  }

  @override
  int get hashCode => imageRoom.hashCode ^ counter_RoomsuperDelocs.hashCode;
}

class ImageRoomModel {
  final String id;
  final List<ImageNet> image_room;
  ImageRoomModel({
    required this.id,
    required this.image_room,
  });

  ImageRoomModel copyWith({
    String? id,
    List<ImageNet>? image_room,
  }) {
    return ImageRoomModel(
      id: id ?? this.id,
      image_room: image_room ?? this.image_room,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_room': image_room.map((x) => x.toMap()).toList(),
    };
  }

  factory ImageRoomModel.fromMap(Map<String, dynamic> map) {
    return ImageRoomModel(
      id: map['_id'] as String,
      image_room: List<ImageNet>.from(
        (map['image_room'] as List<dynamic>).map<ImageNet>(
          (x) => ImageNet.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageRoomModel.fromJson(String source) =>
      ImageRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageRoomModel(id: $id, image_room: $image_room)';

  @override
  bool operator ==(covariant ImageRoomModel other) {
    if (identical(this, other)) return true;

    return other.id == id && listEquals(other.image_room, image_room);
  }

  @override
  int get hashCode => id.hashCode ^ image_room.hashCode;
}

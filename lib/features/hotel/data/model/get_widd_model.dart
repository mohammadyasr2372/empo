// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:party/features/hotel/data/model/image_net.dart';

class GetWiddModel {
  final String id;
  final List shopperId;
  final List HotalId;
  final String NameWiddin;
  final num bookprice;
  final num capacity;
  final num personbook;
  final num capacityMin;
  final List<ImageNet> imagewids_hotal;
  GetWiddModel({
    required this.id,
    required this.shopperId,
    required this.HotalId,
    required this.NameWiddin,
    required this.bookprice,
    required this.capacity,
    required this.personbook,
    required this.capacityMin,
    required this.imagewids_hotal,
  });

  GetWiddModel copyWith({
    String? id,
    List? shopperId,
    List? HotalId,
    String? NameWiddin,
    num? bookprice,
    num? capacity,
    num? personbook,
    num? capacityMin,
    List<ImageNet>? imagewids_hotal,
  }) {
    return GetWiddModel(
      id: id ?? this.id,
      shopperId: shopperId ?? this.shopperId,
      HotalId: HotalId ?? this.HotalId,
      NameWiddin: NameWiddin ?? this.NameWiddin,
      bookprice: bookprice ?? this.bookprice,
      capacity: capacity ?? this.capacity,
      personbook: personbook ?? this.personbook,
      capacityMin: capacityMin ?? this.capacityMin,
      imagewids_hotal: imagewids_hotal ?? this.imagewids_hotal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'shopperId': shopperId,
      'HotalId': HotalId,
      'NameWiddin': NameWiddin,
      'bookprice': bookprice,
      'capacity': capacity,
      'personbook': personbook,
      'capacityMin': capacityMin,
      'imagewids_hotal': imagewids_hotal.map((x) => x.toMap()).toList(),
    };
  }

  factory GetWiddModel.fromMap(Map<String, dynamic> map) {
    return GetWiddModel(
      id: map['_id'] as String,
      shopperId: List.from((map['shopperId'] as List)),
      HotalId: List.from((map['HotalId'] as List)),
      NameWiddin: map['NameWiddin'] as String,
      bookprice: map['bookprice'] as num,
      capacity: map['capacity'] as num,
      personbook: map['personbook'] as num,
      capacityMin: map['capacityMin'] as num,
      imagewids_hotal: List<ImageNet>.from(
        (map['imagewids_hotal'] as List<dynamic>).map<ImageNet>(
          (x) => ImageNet.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetWiddModel.fromJson(String source) =>
      GetWiddModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetWiddModel(id: $id, shopperId: $shopperId, HotalId: $HotalId, NameWiddin: $NameWiddin, bookprice: $bookprice, capacity: $capacity, personbook: $personbook, capacityMin: $capacityMin, imagewids_hotal: $imagewids_hotal)';
  }

  @override
  bool operator ==(covariant GetWiddModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.shopperId, shopperId) &&
        listEquals(other.HotalId, HotalId) &&
        other.NameWiddin == NameWiddin &&
        other.bookprice == bookprice &&
        other.capacity == capacity &&
        other.personbook == personbook &&
        other.capacityMin == capacityMin &&
        listEquals(other.imagewids_hotal, imagewids_hotal);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        shopperId.hashCode ^
        HotalId.hashCode ^
        NameWiddin.hashCode ^
        bookprice.hashCode ^
        capacity.hashCode ^
        personbook.hashCode ^
        capacityMin.hashCode ^
        imagewids_hotal.hashCode;
  }
}

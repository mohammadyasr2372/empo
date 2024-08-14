// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class GetProShopperModel {
  final String id;
  final String name;
  final String email;
  final num mobile;
  final String event_type;
  final num avager_star;
  final num reportCount;
  final String city;
  final String event_name;
  final num location1;
  final num location2;
  GetProShopperModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.event_type,
    required this.avager_star,
    required this.reportCount,
    required this.city,
    required this.event_name,
    required this.location1,
    required this.location2,
  });

  GetProShopperModel copyWith({
    String? id,
    String? name,
    String? email,
    num? mobile,
    String? event_type,
    num? avager_star,
    num? reportCount,
    String? city,
    String? event_name,
    num? location1,
    num? location2,
  }) {
    return GetProShopperModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      event_type: event_type ?? this.event_type,
      avager_star: avager_star ?? this.avager_star,
      reportCount: reportCount ?? this.reportCount,
      city: city ?? this.city,
      event_name: event_name ?? this.event_name,
      location1: location1 ?? this.location1,
      location2: location2 ?? this.location2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'event_type': event_type,
      'avager_star': avager_star,
      'reportCount': reportCount,
      'city': city,
      'event_name': event_name,
      'location1': location1,
      'location2': location2,
    };
  }

  factory GetProShopperModel.fromMap(Map<String, dynamic> map) {
    return GetProShopperModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as num,
      event_type: map['event_type'] as String,
      avager_star: map['avager_star'] as num,
      reportCount: map['reportCount'] as num,
      city: map['city'] as String,
      event_name: map['event_name'] as String,
      location1: map['location1'] as num,
      location2: map['location2'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetProShopperModel.fromJson(String source) =>
      GetProShopperModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetProShopperModel(id: $id, name: $name, email: $email, mobile: $mobile, event_type: $event_type, avager_star: $avager_star, reportCount: $reportCount, city: $city, event_name: $event_name, location1: $location1, location2: $location2)';
  }

  @override
  bool operator ==(covariant GetProShopperModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.mobile == mobile &&
        other.event_type == event_type &&
        other.avager_star == avager_star &&
        other.reportCount == reportCount &&
        other.city == city &&
        other.event_name == event_name &&
        other.location1 == location1 &&
        other.location2 == location2;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        mobile.hashCode ^
        event_type.hashCode ^
        avager_star.hashCode ^
        reportCount.hashCode ^
        city.hashCode ^
        event_name.hashCode ^
        location1.hashCode ^
        location2.hashCode;
  }
}

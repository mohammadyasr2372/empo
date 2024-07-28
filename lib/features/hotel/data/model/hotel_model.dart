// ignore_for_file: non_constant_identifier_names, use_super_parameters

import 'dart:convert';

import '../../domin/entites/hotel_entity.dart';

class HotelModel extends Hotel {
  const HotelModel({
    String? name,
    String? email,
    String? mobile,
    String? password,
    String? image,
  }) : super(
          name: name,
          email: email,
          mobile: mobile,
          password: password,
          image: image,
        );

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'image': image,
    };
  }

  factory HotelModel.fromMap(Map<String, dynamic> map) {
    return HotelModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory HotelModel.fromJson(String source) =>
      HotelModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

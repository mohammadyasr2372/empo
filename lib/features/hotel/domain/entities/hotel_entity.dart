// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_mobileentifier_names, non_constant_identifier_names, file_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Hotel extends Equatable {
  final String? name;
  final String? email;
  final String? mobile;
  final String? password;

  final String? image;

  const Hotel({
    this.name,
    this.email,
    this.mobile,
    this.password,
    this.image,
  });

  @override
  List<Object?> get props {
    return [
      name,
      email,
      mobile,
      password,
      image,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'image': image,
    };
  }

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Hotel.fromJson(String source) =>
      Hotel.fromMap(json.decode(source) as Map<String, dynamic>);
}

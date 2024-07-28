// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_mobileentifier_names, non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Shopper extends Equatable {
  final String? event_type;
  final String? name;
  final String? email;
  final String? mobile;
  final String? password;
  final num? is_verified;
  final String? image;
  final String? location;
  final bool? is_shopper;
  final String? currentPassword;
  final String? newpassword;
  final String? passwordConfirm;
  const Shopper({
    this.event_type,
    this.name,
    this.email,
    this.mobile,
    this.password,
    this.is_verified,
    this.image,
    this.location,
    this.is_shopper,
    this.currentPassword,
    this.newpassword,
    this.passwordConfirm,
  });
  @override
  List<Object?> get props {
    return [
      event_type,
      name,
      email,
      mobile,
      password,
      is_verified,
      image,
      location,
      is_shopper,
      currentPassword,
      newpassword,
      passwordConfirm,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'event_type': event_type,
      'is_verified': is_verified,
      'image': image,
      'location': location,
      'is_shopper': is_shopper,
      'currentPassword': currentPassword,
      'newpassword': newpassword,
      'passwordConfirm': passwordConfirm,
    };
  }

  String toJson() => json.encode(toMap());
}

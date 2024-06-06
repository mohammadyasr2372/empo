// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_mobileentifier_names, non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Shopper extends Equatable {
  final String? event_name;
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
    this.event_name,
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
      event_name,
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
      'event_name': event_name,
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
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

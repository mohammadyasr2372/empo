// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_mobileentifier_names, non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? name;
  final String? email;
  final String? mobile;
  final String? password;
  final String? location;
  final String? image;
  final bool? is_user;
  final String? currentPassword;
  final String? newpassword;
  final String? passwordConfirm;
  const User({
    this.name,
    this.email,
    this.mobile,
    this.password,
    this.location,
    this.image,
    this.is_user,
    this.currentPassword,
    this.newpassword,
    this.passwordConfirm,
  });

  @override
  List<Object?> get props {
    return [
      name,
      email,
      mobile,
      password,
      location,
      image,
      is_user,
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
      'location': location,
      'image': image,
      'is_user': is_user,
      'currentPassword': currentPassword,
      'newpassword': newpassword,
      'passwordConfirm': passwordConfirm,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      is_user: map['is_user'] != null ? map['is_user'] as bool : null,
      currentPassword: map['currentPassword'] != null
          ? map['currentPassword'] as String
          : null,
      newpassword:
          map['newpassword'] != null ? map['newpassword'] as String : null,
      passwordConfirm: map['passwordConfirm'] != null
          ? map['passwordConfirm'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_mobileentifier_names, non_constant_identifier_names


import 'dart:convert';

import 'package:equatable/equatable.dart';

class Admin extends Equatable {
  final String? name;
  final String? email;
  final String? mobile;
  final String? password;
  final bool? is_admin;
  final String? image;
  final String? currentPassword;
  final String? newpassword;
  final String? passwordConfirm;
  const Admin({
    this.name,
    this.email,
    this.mobile,
    this.password,
    this.is_admin,
    this.image,
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
      is_admin,
      image,
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
      'is_admin': is_admin,
      'image': image,
      'currentPassword': currentPassword,
      'newpassword': newpassword,
      'passwordConfirm': passwordConfirm,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      is_admin: map['is_admin'] != null ? map['is_admin'] as bool : null,
      image: map['image'] != null ? map['image'] as String : null,
      currentPassword: map['currentPassword'] != null ? map['currentPassword'] as String : null,
      newpassword: map['newpassword'] != null ? map['newpassword'] as String : null,
      passwordConfirm: map['passwordConfirm'] != null ? map['passwordConfirm'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Admin.fromJson(String source) => Admin.fromMap(json.decode(source) as Map<String, dynamic>);
}

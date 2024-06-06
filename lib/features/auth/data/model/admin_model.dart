// ignore_for_file: non_constant_identifier_names, use_super_parameters

import 'dart:convert';

import '../../domain/entities/admin_entity.dart';

class AdminModel extends Admin {
  const AdminModel({
    String? name,
    String? email,
    String? mobile,
    String? password,
    bool? is_admin,
    String? image,
    String? currentPassword,
    String? newpassword,
    String? passwordConfirm,
  }) : super(
            name: name,
            email: email,
            mobile: mobile,
            password: password,
            is_admin: is_admin,
            image: image,
            currentPassword: currentPassword,
            newpassword: newpassword,
            passwordConfirm: passwordConfirm);
  @override
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

  @override
  String toJson() => json.encode(toMap());

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      is_admin: map['is_admin'] != null ? map['is_admin'] as bool : null,
      image: map['image'] != null ? map['image'] as String : null,
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

  factory AdminModel.fromJson(String source) =>
      AdminModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

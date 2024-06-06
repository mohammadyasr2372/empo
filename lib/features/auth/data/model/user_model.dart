// ignore_for_file: non_constant_identifier_names, use_super_parameters

import 'dart:convert';

import '../../domain/entities/user_entity.dart';

class UserModel extends User {
  const UserModel({
    String? name,
    String? email,
    String? mobile,
    String? password,
    String? location,
    String? image,
    bool? is_user,
    String? currentPassword,
    String? newpassword,
    String? passwordConfirm,
  }) : super(
            name: name,
            email: email,
            mobile: mobile,
            password: password,
            location: location,
            image: image,
            is_user: is_user,
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
      'location': location,
      'image': image,
      'is_user': is_user,
      'currentPassword': currentPassword,
      'newpassword': newpassword,
      'passwordConfirm': passwordConfirm,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      is_user: map['is_user'] != null ? map['is_user'] as bool : null,
      currentPassword: map['currentPassword'] != null ? map['currentPassword'] as String : null,
      newpassword: map['newpassword'] != null ? map['newpassword'] as String : null,
      passwordConfirm: map['passwordConfirm'] != null ? map['passwordConfirm'] as String : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

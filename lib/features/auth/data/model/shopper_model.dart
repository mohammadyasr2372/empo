// ignore_for_file: non_constant_identifier_names, use_super_parameters

import 'dart:convert';

import '../../domain/entities/shopper_entity.dart';

class ShopperModel extends Shopper {
  const ShopperModel({
    String? event_type,
    String? name,
    String? email,
    String? mobile,
    String? password,
    num? is_verified,
    String? image,
    String? location,
    bool? is_shopper,
    String? currentPassword,
    String? newpassword,
    String? passwordConfirm,
  }) : super(
            event_type: event_type,
            name: name,
            email: email,
            mobile: mobile,
            password: password,
            is_verified: is_verified,
            image: image,
            location: location,
            is_shopper: is_shopper,
            currentPassword: currentPassword,
            newpassword: newpassword,
            passwordConfirm: passwordConfirm);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event_type': event_type,
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

  factory ShopperModel.fromMap(Map<String, dynamic> map) {
    return ShopperModel(
      event_type:
          map['event_type'] != null ? map['event_type'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      is_verified:
          map['is_verified'] != null ? map['is_verified'] as num : null,
      image: map['image'] != null ? map['image'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      is_shopper: map['is_shopper'] != null ? map['is_shopper'] as bool : null,
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

  @override
  String toJson() => json.encode(toMap());

  factory ShopperModel.fromJson(String source) =>
      ShopperModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

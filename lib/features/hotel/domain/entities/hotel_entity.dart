// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_mobileentifier_names, non_constant_identifier_names, file_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'room_entity.dart';

class Hotel extends Equatable {
  final String? name;
  final String? email;
  final String? mobile;
  final String? password;
  final List<String>? image;
  final List<Room>? rooms;
  const Hotel({
    this.name,
    this.email,
    this.mobile,
    this.password,
    this.image,
    this.rooms,
  });

  Hotel copyWith({
    String? name,
    String? email,
    String? mobile,
    String? password,
    List<String>? image,
    List<Room>? rooms,
  }) {
    return Hotel(
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
      image: image ?? this.image,
      rooms: rooms ?? this.rooms,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'image': image,
      'rooms': rooms?.map((x) => x.toMap()).toList(),
    };
  }

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      image: map['image'] != null
          ? List<String>.from((map['image'] as List<String>))
          : null,
      rooms: map['rooms'] != null
          ? List<Room>.from(
              (map['rooms'] as List<int>).map<Room?>(
                (x) => Room.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Hotel.fromJson(String source) =>
      Hotel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      name,
      email,
      mobile,
      password,
      image,
      rooms,
    ];
  }
}

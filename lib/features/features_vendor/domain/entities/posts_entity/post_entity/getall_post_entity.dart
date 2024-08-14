import 'package:equatable/equatable.dart';

class ReportGetAllPostsEntity extends Equatable {
  ReportGetAllPostsEntity({
    required this.success,
    required this.message,
    required this.datagetallpost,
  });

  final bool? success;
  final String? message;
  final List<DataGetAllPostEntity> datagetallpost;

  @override
  List<Object?> get props => [success, message, datagetallpost];
}

class DataGetAllPostEntity extends Equatable {
  DataGetAllPostEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.shopperId,
    required this.commentCount,
    required this.createdAt,
  });

  final String? id;
  final String? title;
  final String? content;
  final List<ShopperIdEnitiy> shopperId;
  final int? commentCount;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        shopperId,
        commentCount,
        createdAt,
      ];
}

class ShopperIdEnitiy extends Equatable {
  ShopperIdEnitiy({
    required this.id,
    required this.email,
    required this.city,
    required this.eventName,
    required this.image,
  });

  final String? id;
  final String? email;
  final String? city;
  final String? eventName;
  final String? image;

  @override
  List<Object?> get props => [
        id,
        email,
        city,
        eventName,
        image,
      ];
}

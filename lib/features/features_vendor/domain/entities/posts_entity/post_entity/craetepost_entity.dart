import 'dart:io';

import 'package:equatable/equatable.dart';

class ReportPostsEntity extends Equatable {
  ReportPostsEntity({
    required this.success,
    required this.message,
    required this.dataPost,
  });

  final bool? success;
  final String? message;
  final DataPostEntity? dataPost;

  @override
  // TODO: implement props
  List<Object?> get props => [success, message, dataPost];
}

class DataPostEntity extends Equatable {
  DataPostEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.images,
  });
  final String? id;
  final String? title;
  final String? content;
  final List<ImageEntity> images;

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, content, images];
}

class ImageEntity extends Equatable {
  ImageEntity({
    required this.url,
    required this.id,
  });

  final String? url;
  final String? id;

  @override
  // TODO: implement props
  List<Object?> get props => [url, id];
}

class AddPostEntity extends Equatable {
  final String? title;
  final String? content;
  final List<File> images;
  AddPostEntity({
    required this.title,
    required this.content,
    required this.images,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [title, content, images];
}

class AddImageEntity extends Equatable {
  AddImageEntity({
    required this.images,
  });

  final File? images;

  @override
  // TODO: implement props
  List<Object?> get props => [
        images,
      ];
}

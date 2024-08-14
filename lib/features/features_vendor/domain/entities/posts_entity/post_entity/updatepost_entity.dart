
import 'package:equatable/equatable.dart';

class ReportUpdatepostEntity {
  ReportUpdatepostEntity({
    required this.success,
    required this.msg,
    required this.title,
    required this.content,
    required this.images,
  });

  final bool? success;
  final String? msg;
  final String? title;
  final String? content;
  final List<ImageEntity> images;
}

class ImageEntity extends Equatable {
  ImageEntity({
    required this.id,
  });

  final String? id;

  @override
  List<Object?> get props => throw UnimplementedError();
}

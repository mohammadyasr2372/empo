import 'package:equatable/equatable.dart';

class AddcommentEntity extends Equatable {
  AddcommentEntity({
    required this.contentComment,
    required this.postId,
  });

  final String? contentComment;
  final String? postId;

  @override
  List<Object?> get props => [contentComment, postId];
}

class ReportAddcommentEntity extends Equatable {
  ReportAddcommentEntity({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final ContentCommentEntity? data;

  @override
  // TODO: implement props
  List<Object?> get props => [data, message, success];
}

class ContentCommentEntity extends Equatable {
  ContentCommentEntity({
    required this.contentComment,
    required this.createdAt,
  });

  final String? contentComment;
  final DateTime? createdAt;

  @override
  // TODO: implement props
  List<Object?> get props => [contentComment, createdAt];
}

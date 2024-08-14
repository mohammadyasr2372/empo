import 'package:equatable/equatable.dart';

class UpdatecommentEntity extends Equatable {
  UpdatecommentEntity({
    required this.commentId,
    required this.contentComment,
  });

  final String? commentId;
  final String? contentComment;

  @override
  List<Object?> get props => [commentId, contentComment];
}

class ReportMessageUpdateCommentEntity extends Equatable {
  ReportMessageUpdateCommentEntity({
    required this.status,
    required this.message,
  });

  final bool? status;
  final String? message;

  @override
  List<Object?> get props => [status, message];
}

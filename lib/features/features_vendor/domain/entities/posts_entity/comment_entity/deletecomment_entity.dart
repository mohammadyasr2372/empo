import 'package:equatable/equatable.dart';

class DeleteIDCommentEntity extends Equatable {
  DeleteIDCommentEntity({
    required this.commentId,
  });

  final String? commentId;

  @override
  List<Object?> get props => [commentId];
}

class ReportDeleteCommentEntity extends Equatable {
  ReportDeleteCommentEntity({
    required this.success,
    required this.message,
  });

  final bool? success;
  final String? message;

  @override
  // TODO: implement props
  List<Object?> get props => [success, message];
}

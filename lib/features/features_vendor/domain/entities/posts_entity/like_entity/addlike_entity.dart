import 'package:equatable/equatable.dart';

class PostID_Entity extends Equatable {
  PostID_Entity({
    required this.postId,
  });

  final String? postId;

  @override
  List<Object?> get props => [postId];
}

class ReportAddLikeEntity extends Equatable {
  ReportAddLikeEntity({
    required this.success,
    required this.message,
  });

  final bool? success;
  final String? message;

  @override
  List<Object?> get props => [message, success];
}

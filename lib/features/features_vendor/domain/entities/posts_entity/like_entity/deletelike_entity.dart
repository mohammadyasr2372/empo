import 'package:equatable/equatable.dart';

class DeletelikeEntity extends Equatable {
  DeletelikeEntity({
    required this.success,
    required this.message,
  });

  final bool? success;
  final String? message;

  @override
  List<Object?> get props => [success, message];
}

class DeleteLikeIdPostEntity extends Equatable {
  DeleteLikeIdPostEntity({
    required this.postId,
  });

  final String? postId;

  @override
  List<Object?> get props => [postId];
}

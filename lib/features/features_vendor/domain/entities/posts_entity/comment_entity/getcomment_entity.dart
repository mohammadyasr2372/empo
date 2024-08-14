import 'package:equatable/equatable.dart';

class ReportGetCommentEntity extends Equatable {
  ReportGetCommentEntity({
    required this.status,
    required this.data,
  });

  final bool? status;
  final DataGetCommnetEntity? data;

  @override
  List<Object?> get props => [status, data];
}

class DataGetCommnetEntity extends Equatable {
  DataGetCommnetEntity({
    required this.info,
    required this.counterOfComment,
  });

  final List<InfoGetCommnetEntity> info;
  final int? counterOfComment;

  @override
  List<Object?> get props => [info, counterOfComment];
}

class InfoGetCommnetEntity extends Equatable {
  InfoGetCommnetEntity({
    required this.id,
    required this.userId,
  });

  final String? id;
  final UserIdGetCommnetEntity? userId;

  @override
  List<Object?> get props => [id, userId];
}

class UserIdGetCommnetEntity extends Equatable {
  UserIdGetCommnetEntity({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  @override
  List<Object?> get props => [id, name];
}

class CommentPostIDEntity extends Equatable {
  CommentPostIDEntity({
    required this.postId,
  });

  final String? postId;

  @override
  List<Object?> get props => [
        postId,
      ];
}

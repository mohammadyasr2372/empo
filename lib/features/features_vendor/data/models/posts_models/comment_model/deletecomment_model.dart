import '../../../../domain/entities/posts_entity/comment_entity/deletecomment_entity.dart';

class ReportDeleteCommentModel extends ReportDeleteCommentEntity {
  ReportDeleteCommentModel({
    required this.success,
    required this.message,
  }) : super(success: success, message: message);

  @override
  final bool? success;
  @override
  final String? message;

  factory ReportDeleteCommentModel.fromJson(Map<String, dynamic> json) {
    return ReportDeleteCommentModel(
      success: json["success"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
  ReportDeleteCommentEntity toEntity() {
    return ReportDeleteCommentEntity(
      success: success,
      message: message,
    );
  }
}

class DeleteIDCommentModel extends DeleteIDCommentEntity {
  DeleteIDCommentModel({
    required this.commentId,
  }) : super(commentId: commentId);

  @override
  final String? commentId;

  factory DeleteIDCommentModel.fromJson(Map<String, dynamic> json) {
    return DeleteIDCommentModel(
      commentId: json["commentId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
      };
}

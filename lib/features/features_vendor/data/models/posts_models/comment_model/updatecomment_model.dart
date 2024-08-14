import '../../../../domain/entities/posts_entity/comment_entity/updatecomment_entity.dart';

class UpdatecommentModel extends UpdatecommentEntity {
  UpdatecommentModel({
    required this.commentId,
    required this.contentComment,
  }) : super(commentId: commentId, contentComment: contentComment);

  final String? commentId;
  final String? contentComment;

  factory UpdatecommentModel.fromJson(Map<String, dynamic> json) {
    return UpdatecommentModel(
      commentId: json["commentId"],
      contentComment: json["content_comment"],
    );
  }

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "content_comment": contentComment,
      };
}

class ReportMessageUpdateCommentModel extends ReportMessageUpdateCommentEntity {
  ReportMessageUpdateCommentModel({
    required this.status,
    required this.message,
  }) : super(status: status, message: message);

  final bool? status;
  final String? message;

  factory ReportMessageUpdateCommentModel.fromJson(Map<String, dynamic> json) {
    return ReportMessageUpdateCommentModel(
      status: json["status"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": message,
      };
  ReportMessageUpdateCommentEntity toEntity() {
    return ReportMessageUpdateCommentEntity(
      status: status,
      message: message,
    );
  }
}

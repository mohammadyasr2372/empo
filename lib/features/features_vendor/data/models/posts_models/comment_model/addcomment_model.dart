import '../../../../domain/entities/posts_entity/comment_entity/addcomment_entity.dart';

class AddcommentModel extends AddcommentEntity {
  AddcommentModel({
    required this.contentComment,
    required this.postId,
  }) : super(contentComment: contentComment, postId: postId);

  final String? contentComment;
  final String? postId;

  factory AddcommentModel.fromJson(Map<String, dynamic> json) {
    return AddcommentModel(
      contentComment: json["content_comment"],
      postId: json["postId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "content_comment": contentComment,
        "postId": postId,
      };
}

class ReportAddcommentModel extends ReportAddcommentEntity {
  ReportAddcommentModel({
    required this.success,
    required this.message,
    required this.data,
  }) : super(success: success, message: message, data: data);

  final bool? success;
  final String? message;
  final ContentCommentModle? data;

  factory ReportAddcommentModel.fromJson(Map<String, dynamic> json) {
    return ReportAddcommentModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? null
          : ContentCommentModle.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
  ReportAddcommentEntity toEntity() {
    return ReportAddcommentEntity(
      success: success,
      message: message,
      data: data,
    );
  }
}

class ContentCommentModle extends ContentCommentEntity {
  ContentCommentModle({
    required this.contentComment,
    required this.createdAt,
  }) : super(contentComment: contentComment, createdAt: createdAt);

  final String? contentComment;
  final DateTime? createdAt;

  factory ContentCommentModle.fromJson(Map<String, dynamic> json) {
    return ContentCommentModle(
      contentComment: json["content_comment"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "content_comment": contentComment,
        "createdAt": createdAt?.toIso8601String(),
      };
}

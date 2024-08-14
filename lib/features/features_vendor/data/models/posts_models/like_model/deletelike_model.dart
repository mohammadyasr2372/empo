import '../../../../domain/entities/posts_entity/like_entity/deletelike_entity.dart';

class DeletelikeModel extends DeletelikeEntity {
  DeletelikeModel({
    required this.success,
    required this.message,
  }) : super(success: success, message: message);

  final bool? success;
  final String? message;

  factory DeletelikeModel.fromJson(Map<String, dynamic> json) {
    return DeletelikeModel(
      success: json["success"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
  DeletelikeEntity toEntity() {
    return DeletelikeEntity(
      success: success,
      message: message,
    );
  }
}

class DeleteLikeIdPostModel extends DeleteLikeIdPostEntity {
  DeleteLikeIdPostModel({
    required this.postId,
  }) : super(postId: postId);

  final String? postId;

  factory DeleteLikeIdPostModel.fromJson(Map<String, dynamic> json) {
    return DeleteLikeIdPostModel(
      postId: json["postId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "postId": postId,
      };
}

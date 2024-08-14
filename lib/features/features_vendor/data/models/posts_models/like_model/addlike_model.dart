import '../../../../domain/entities/posts_entity/like_entity/addlike_entity.dart';

class PostID_Model extends PostID_Entity {
  PostID_Model({
    required this.postId,
  }) : super(postId: postId);

  final String? postId;

  factory PostID_Model.fromJson(Map<String, dynamic> json) {
    return PostID_Model(
      postId: json["postId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "postId": postId,
      };
}

class ReportAddLikeModel extends ReportAddLikeEntity {
  ReportAddLikeModel({
    required this.success,
    required this.message,
  }) : super(success: success, message: message);

  final bool? success;
  final String? message;

  factory ReportAddLikeModel.fromJson(Map<String, dynamic> json) {
    return ReportAddLikeModel(
      success: json["success"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
  ReportAddLikeEntity toEntity() {
    return ReportAddLikeEntity(
      success: success,
      message: message,
    );
  }
}

class ReportAddLikeMo {
  ReportAddLikeMo({
    required this.success,
    required this.message,
    required this.boolLike,
  });

  final bool? success;
  final String? message;
  final bool? boolLike;

  factory ReportAddLikeMo.fromJson(Map<String, dynamic> json) {
    return ReportAddLikeMo(
      success: json["success"],
      message: json["message"],
      boolLike: json["Bool_like"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Bool_like": boolLike,
      };
}

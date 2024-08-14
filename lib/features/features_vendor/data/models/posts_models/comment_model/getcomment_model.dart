// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import '../../../../domain/entities/posts_entity/comment_entity/getcomment_entity.dart';

class ReportGetCommentModel extends ReportGetCommentEntity {
  ReportGetCommentModel({
    required this.status,
    required this.data,
  }) : super(status: status, data: data);

  final bool? status;
  final DataGetCommnetModel? data;

  factory ReportGetCommentModel.fromJson(Map<String, dynamic> json) {
    return ReportGetCommentModel(
      status: json["status"],
      data: json["data"] == null
          ? null
          : DataGetCommnetModel.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
  ReportGetCommentEntity toEntity() {
    return ReportGetCommentEntity(
      status: status,
      data: data,
    );
  }
}

class DataGetCommnetModel extends DataGetCommnetEntity {
  DataGetCommnetModel({
    required this.info,
    required this.counterOfComment,
  }) : super(info: info, counterOfComment: counterOfComment);

  final List<InfoGetCommnetModle> info;
  final int? counterOfComment;

  factory DataGetCommnetModel.fromJson(Map<String, dynamic> json) {
    return DataGetCommnetModel(
      info: json["info"] == null
          ? []
          : List<InfoGetCommnetModle>.from(
              json["info"]!.map((x) => InfoGetCommnetModle.fromJson(x))),
      counterOfComment: json["counter_of_comment"],
    );
  }

  Map<String, dynamic> toJson() => {
        "info": info.map((x) => x.toJson()).toList(),
        "counter_of_comment": counterOfComment,
      };
}

class InfoGetCommnetModle extends InfoGetCommnetEntity {
  InfoGetCommnetModle({
    required this.id,
    required this.userId,
  }) : super(id: id, userId: userId);

  final String? id;
  final UserIdGetCommnetModle? userId;

  factory InfoGetCommnetModle.fromJson(Map<String, dynamic> json) {
    return InfoGetCommnetModle(
      id: json["_id"],
      userId: json["userId"] == null
          ? null
          : UserIdGetCommnetModle.fromJson(json["userId"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId?.toJson(),
      };
}

class UserIdGetCommnetModle extends UserIdGetCommnetEntity {
  UserIdGetCommnetModle({
    required this.id,
    required this.name,
  }) : super(id: id, name: name);

  final String? id;
  final String? name;

  factory UserIdGetCommnetModle.fromJson(Map<String, dynamic> json) {
    return UserIdGetCommnetModle(
      id: json["_id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class CommentPostIDModel extends CommentPostIDEntity {
  final String postId;
  CommentPostIDModel({
    required this.postId,
  }) : super(postId: postId);

  CommentPostIDModel copyWith({
    String? postId,
  }) {
    return CommentPostIDModel(
      postId: postId ?? this.postId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
    };
  }

  factory CommentPostIDModel.fromMap(Map<String, dynamic> map) {
    return CommentPostIDModel(
      postId: map['postId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentPostIDModel.fromJson(String source) =>
      CommentPostIDModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PostIDModel(postId: $postId)';

  @override
  bool operator ==(covariant CommentPostIDModel other) {
    if (identical(this, other)) return true;

    return other.postId == postId;
  }

  @override
  int get hashCode => postId.hashCode;
}

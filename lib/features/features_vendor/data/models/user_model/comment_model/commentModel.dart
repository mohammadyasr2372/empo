// ignore_for_file: file_names

class CommenModel {
  CommenModel({
    required this.status,
    required this.data,
  });

  final bool? status;
  final DataComment? data;

  factory CommenModel.fromJson(Map<String, dynamic> json) {
    return CommenModel(
      status: json["status"],
      data: json["data"] == null ? null : DataComment.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class DataComment {
  DataComment({
    required this.info,
    required this.counterOfComment,
  });

  final List<InfoComment> info;
  final int? counterOfComment;

  factory DataComment.fromJson(Map<String, dynamic> json) {
    return DataComment(
      info: json["info"] == null
          ? []
          : List<InfoComment>.from(
              json["info"]!.map((x) => InfoComment.fromJson(x))),
      counterOfComment: json["counter_of_comment"],
    );
  }

  Map<String, dynamic> toJson() => {
        "info": info.map((x) => x.toJson()).toList(),
        "counter_of_comment": counterOfComment,
      };
}

class InfoComment {
  InfoComment({
    required this.id,
    required this.userId,
    required this.contentComment,
    required this.createdAt,
  });

  final String? id;
  final UserIdInfo? userId;
  final String? contentComment;
  final DateTime? createdAt;

  factory InfoComment.fromJson(Map<String, dynamic> json) {
    return InfoComment(
      id: json["_id"],
      userId:
          json["userId"] == null ? null : UserIdInfo.fromJson(json["userId"]),
      contentComment: json["content_comment"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId?.toJson(),
        "content_comment": contentComment,
        "createdAt": createdAt?.toIso8601String(),
      };
}

class UserIdInfo {
  UserIdInfo({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory UserIdInfo.fromJson(Map<String, dynamic> json) {
    return UserIdInfo(
      id: json["_id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

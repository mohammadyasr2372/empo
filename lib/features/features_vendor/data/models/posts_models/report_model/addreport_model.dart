import '../../../../domain/entities/posts_entity/report_entity/addreport_entity.dart';

class AddReportModel extends AddReportEntity {
  AddReportModel({
    required this.reason,
    required this.shopperId,
    required this.postId,
  }) : super(reason: reason, shopperId: shopperId, postId: postId);

  final String? reason;
  final String? shopperId;
  final String? postId;

  factory AddReportModel.fromJson(Map<String, dynamic> json) {
    return AddReportModel(
      reason: json["reason"],
      shopperId: json["shopperId"],
      postId: json["postId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "reason": reason,
        "shopperId": shopperId,
        "postId": postId,
      };
}

class GetReportModel extends GetReportEntity {
  GetReportModel({
    required this.success,
    required this.message,
    required this.data,
  }) : super(success: success, message: message, data: data);

  final bool? success;
  final String? message;
  final DataReportModel? data;

  factory GetReportModel.fromJson(Map<String, dynamic> json) {
    return GetReportModel(
      success: json["success"],
      message: json["message"],
      data:
          json["data"] == null ? null : DataReportModel.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
  GetReportEntity toEntity() {
    return GetReportEntity(
      success: success,
      message: message,
      data: data,
    );
  }
}

class DataReportModel extends DataReportEntity {
  DataReportModel({
    required this.reason,
    required this.createdAt,
  }) : super(reason: reason, createdAt: createdAt);

  final String? reason;
  final DateTime? createdAt;

  factory DataReportModel.fromJson(Map<String, dynamic> json) {
    return DataReportModel(
      reason: json["reason"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "reason": reason,
        "createdAt": createdAt?.toIso8601String(),
      };
}

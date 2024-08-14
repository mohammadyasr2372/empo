import '../../../../domain/entities/wedding_hall_entity/post_entity/poststar.dart';

class PostStarModle extends PostStarEntity {
  PostStarModle({
    required this.starId,
    required this.star,
  }) : super(starId: starId, star: star);

  final String? starId;
  final String? star;

  factory PostStarModle.fromJson(Map<String, dynamic> json) {
    return PostStarModle(
      starId: json["starId"],
      star: json["star"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'starId': starId,
      'star': star,
    };
  }
}

class ReportStarModel extends ReportStar {
  ReportStarModel({
    required this.success,
    required this.message,
  }) : super(success: success, message: message);

  final bool? success;
  final String? message;

  factory ReportStarModel.fromJson(Map<String, dynamic> json) {
    return ReportStarModel(
      success: json["success"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
  ReportStar toEntity() {
    return ReportStar(
      success: success,
      message: message,
    );
  }
}

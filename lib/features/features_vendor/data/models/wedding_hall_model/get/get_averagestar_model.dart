import '../../../../domain/entities/wedding_hall_entity/get_entity/averagestar_entity.dart';

class averageStarsModel extends averageStarsEntity {
  averageStarsModel({
    required this.success,
    required this.message,
    required this.avagerStars,
  }) : super(success: success, message: message, avagerStars: avagerStars);

  final bool? success;
  final String? message;
  final double? avagerStars;

  factory averageStarsModel.fromJson(Map<String, dynamic> json) {
    return averageStarsModel(
      success: json["success"],
      message: json["message"],
      avagerStars: json["avager_stars"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "avager_stars": avagerStars,
      };
  averageStarsEntity toEntity() {
    return averageStarsEntity(
      success: success,
      message: message,
      avagerStars: avagerStars,
    );
  }
}

class IdStarModel extends IdStarEntity {
  IdStarModel({
    required this.starId,
  }) : super(starId: starId);

  final String? starId;

  factory IdStarModel.fromJson(Map<String, dynamic> json) {
    return IdStarModel(
      starId: json["starId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "starId": starId,
      };

  Map<String, dynamic> toMap() {
    return {
      'starId': starId,
    };
  }
}

import '../../../../domain/entities/posts_entity/like_entity/get_counter_like_entity.dart';

class GetCounterLikeModle extends GetCounterLikeEntity {
  GetCounterLikeModle({
    required this.success,
    required this.counterLikes,
  }) : super(success: success, counterLikes: counterLikes);

  final bool? success;
  final int? counterLikes;

  factory GetCounterLikeModle.fromJson(Map<String, dynamic> json) {
    return GetCounterLikeModle(
      success: json["success"],
      counterLikes: json["counter_likes"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "counter_likes": counterLikes,
      };
  GetCounterLikeEntity toEntity() {
    return GetCounterLikeEntity(
      success: success,
      counterLikes: counterLikes,
    );
  }
}

import '../../../../domain/entities/user_entity/getcity_entity.dart';

class GetcityModel extends GetcityEntity {
  GetcityModel({
    required this.success,
    required this.city,
  }) : super(success: success, city: city);

  final bool? success;
  final List<String> city;

  factory GetcityModel.fromJson(Map<String, dynamic> json) {
    return GetcityModel(
      success: json["success"],
      city: json["city"] == null
          ? []
          : List<String>.from(json["city"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "city": city.map((x) => x).toList(),
      };
  GetcityEntity toEntity() {
    return GetcityEntity(
      success: success,
      city: city,
    );
  }
}

import '../../../../domain/entities/wedding_hall_entity/post_entity/add_image_hopit.dart';

class add_image_hospit extends entity_add_image_hospit {
  add_image_hospit({
    required this.success,
    required this.msg,
    required this.imagehospit,
  }) : super(success: false, msg: msg, imagehospit: imagehospit);

  final bool? success;
  final String? msg;
  final List<Imagehospit> imagehospit;

  factory add_image_hospit.fromJson(Map<String, dynamic> json) {
    return add_image_hospit(
      success: json["success"],
      msg: json["msg"],
      imagehospit: json["images"] == null
          ? []
          : List<Imagehospit>.from(
              json["images"]!.map((x) => Imagehospit.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "images": imagehospit.map((x) => x.toJson()).toList(),
      };
}

class Imagehospit extends Entity_Imagehospit {
  Imagehospit({
    required this.id,
  }) : super(id: id);

  final String? id;

  factory Imagehospit.fromJson(Map<String, dynamic> json) {
    return Imagehospit(
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
      };
}

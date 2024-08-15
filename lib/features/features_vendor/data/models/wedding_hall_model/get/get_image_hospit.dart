class Getimagehospit {
  Getimagehospit({
    required this.success,
    required this.imageHospit,
  });

  final bool? success;
  final List<ImageHospit> imageHospit;

  factory Getimagehospit.fromJson(Map<String, dynamic> json) {
    return Getimagehospit(
      success: json["success"],
      imageHospit: json["image_hospit"] == null
          ? []
          : List<ImageHospit>.from(
              json["image_hospit"]!.map((x) => ImageHospit.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "image_hospit": imageHospit.map((x) => x?.toJson()).toList(),
      };
}

class ImageHospit {
  ImageHospit({
    required this.url,
    required this.id,
  });

  final String? url;
  final String? id;

  factory ImageHospit.fromJson(Map<String, dynamic> json) {
    return ImageHospit(
      url: json["url"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "_id": id,
      };
}

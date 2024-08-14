import '../../../../domain/entities/posts_entity/post_entity/updatepost_entity.dart';

class ReportUpdatepostModel extends ReportUpdatepostEntity {
  ReportUpdatepostModel({
    required this.success,
    required this.msg,
    required this.title,
    required this.content,
    required this.images,
  }) : super(
          success: success,
          msg: msg,
          title: title,
          content: content,
          images: images,
        );

  final bool? success;
  final String? msg;
  final String? title;
  final String? content;
  final List<ImageModel> images;

  factory ReportUpdatepostModel.fromJson(Map<String, dynamic> json) {
    return ReportUpdatepostModel(
      success: json["success"],
      msg: json["msg"],
      title: json["title"],
      content: json["content"],
      images: json["images"] == null
          ? []
          : List<ImageModel>.from(
              json["images"]!.map((x) => ImageModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "title": title,
        "content": content,
        "images": images.map((x) => x.toJson()).toList(),
      };
  ReportUpdatepostEntity toEntity() {
    return ReportUpdatepostEntity(
      success: success,
      msg: msg,
      title: title,
      content: content,
      images: images,
    );
  }
}

class ImageModel extends ImageEntity {
  ImageModel({
    required this.id,
  }) : super(id: id);

  final String? id;

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
      };
}

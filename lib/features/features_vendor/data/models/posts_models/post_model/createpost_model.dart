// import 'dart:io';

// import '../../../../domain/entities/posts_entity/post_entity/craetepost_entity.dart';

// class ReportPostModel extends ReportPostsEntity {
//   ReportPostModel({
//     required this.success,
//     required this.message,
//     required this.dataPost,
//   }) : super(success: success, message: message, dataPost: dataPost);

//   final bool? success;
//   final String? message;
//   final DataPostModle? dataPost;

//   factory ReportPostModel.fromJson(Map<String, dynamic> json) {
//     return ReportPostModel(
//       success: json["success"],
//       message: json["message"],
//       dataPost: json["DataPost"] == null
//           ? null
//           : DataPostModle.fromJson(json["DataPost"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "DataPost": dataPost?.toJson(),
//       };
//   ReportPostsEntity toEntity() {
//     return ReportPostsEntity(
//       success: success,
//       message: message,
//       dataPost: dataPost,
//     );
//   }
// }

// class DataPostModle extends DataPostEntity {
//   DataPostModle({
//     required this.shopperId,
//     required this.title,
//     required this.content,
//     required this.images,
//   }) : super(
//             title: title,
//             content: content,
//             images: images,
//             shopperId: shopperId);

//   final String? title;
//   final String? content;
//   final List<ImageModel> images;
//   final String? shopperId;

//   factory DataPostModle.fromJson(Map<String, dynamic> json) {
//     return DataPostModle(
//       title: json["title"],
//       content: json["content"],
//       shopperId: json["shopperId"],
//       images: json["images"] == null
//           ? []
//           : List<ImageModel>.from(json["images"]!.map((x) => ImageModel.fromJson(x))),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "content": content,
//         'shopperId': shopperId,
//         "images": images.map((x) => x.toJson()).toList(),
//       };
// }

// class ImageModel extends ImageEntity {
//   ImageModel({
//     required this.id,
//   }) : super(id: id);

//   final File? id;

//   factory ImageModel.fromJson(Map<String, dynamic> json) {
//     return ImageModel(
//       id: json["_id"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//       };
// }

// ignore_for_file: overridden_fields

import 'dart:io';

import '../../../../domain/entities/posts_entity/post_entity/craetepost_entity.dart';

class ReportPostModel extends ReportPostsEntity {
  ReportPostModel({
    required this.success,
    required this.message,
    required this.dataPost,
  }) : super(success: success, message: message, dataPost: dataPost);

  @override
  final bool? success;
  @override
  final String? message;
  @override
  final DataPostModle? dataPost;

  factory ReportPostModel.fromJson(Map<String, dynamic> json) {
    return ReportPostModel(
      success: json["success"],
      message: json["message"],
      dataPost: json["DataPost"] == null
          ? null
          : DataPostModle.fromJson(json["DataPost"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "DataPost": dataPost?.toJson(),
      };
  ReportPostsEntity toEntity() {
    return ReportPostsEntity(
      success: success,
      message: message,
      dataPost: dataPost,
    );
  }
}

class DataPostModle extends DataPostEntity {
  DataPostModle({
    required this.id,
    required this.title,
    required this.content,
    required this.images,
  }) : super(
          id: id,
          title: title,
          content: content,
          images: images,
        );

  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final List<ImageModel> images;

  factory DataPostModle.fromJson(Map<String, dynamic> json) {
    return DataPostModle(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      images: json["images"] == null
          ? []
          : List<ImageModel>.from(
              json["images"]!.map((x) => ImageModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "images": images.map((x) => x.toJson()).toList(),
      };
}

class ImageModel extends ImageEntity {
  ImageModel({
    required this.url,
    required this.id,
  }) : super(url: url, id: id);

  @override
  final String? url;
  @override
  final String? id;

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json["url"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "_id": id,
      };
}

/////////////////////Post//////////////////////////////
class AddPostModel extends AddPostEntity {
  AddPostModel({
    required this.shopperId,
    required this.title,
    required this.content,
    required this.images,
  }) : super(
          title: title,
          content: content,
          images: images,
          shopperId: shopperId,
        );
  @override
  final String? shopperId;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final List<AddImageModel> images;

  factory AddPostModel.fromJson(Map<String, dynamic> json) {
    return AddPostModel(
      shopperId: json['shopperId'],
      title: json["title"],
      content: json["content"],
      images: json["images"] == null
          ? []
          : List<AddImageModel>.from(
              json["images"]!.map(
                (x) => ImageModel.fromJson(x),
              ),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        'shopperId': shopperId,
        "title": title,
        "content": content,
        "images": images.map((x) => x.toJson()).toList(),
      };
}

class AddImageModel extends AddImageEntity {
  AddImageModel({
    required this.images,
  }) : super(
          images: images,
        );

  @override
  final File? images;

  factory AddImageModel.fromJson(Map<String, dynamic> json) {
    return AddImageModel(
      images: json["images"],
    );
  }

  Map<String, dynamic> toJson() => {
        "images": images,
      };
}

// import '../../../../domain/entities/posts_entity/post_entity/getall_post_entity.dart';

// class ReportGetAllPostsModle extends ReportGetAllPostsEntity {
//   ReportGetAllPostsModle({
//     required this.success,
//     required this.message,
//     required this.dataPost,
//   }) : super(success: success, message: message, datagetallpost: dataPost);

//   final bool? success;
//   final String? message;
//   final List<DataGetAllPostModel> dataPost;

//   factory ReportGetAllPostsModle.fromJson(Map<String, dynamic> json) {
//     return ReportGetAllPostsModle(
//       success: json["success"],
//       message: json["message"],
//       dataPost: json["DataPost"] == null
//           ? []
//           : List<DataGetAllPostModel>.from(
//               json["DataPost"]!.map((x) => DataGetAllPostModel.fromJson(x))),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "DataPost": dataPost.map((x) => x.toJson()).toList(),
//       };
//   ReportGetAllPostsEntity toEntity() {
//     return ReportGetAllPostsEntity(
//       success: success,
//       message: message,
//       datagetallpost: datagetallpost,
//     );
//   }
// }

// class DataGetAllPostModel extends DataGetAllPostEntity {
//   DataGetAllPostModel({
//     required this.id,
//     required this.title,
//     required this.content,
//     required this.shopperId,
//     required this.commentCount,
//     required this.createdAt,
//   }) : super(
//             id: id,
//             title: title,
//             content: content,
//             shopperId: shopperId,
//             commentCount: commentCount,
//             createdAt: createdAt);

//   final String? id;
//   final String? title;
//   final String? content;
//   final List<ShopperIdModel> shopperId;
//   final int? commentCount;
//   final DateTime? createdAt;

//   factory DataGetAllPostModel.fromJson(Map<String, dynamic> json) {
//     return DataGetAllPostModel(
//       id: json["_id"],
//       title: json["title"],
//       content: json["content"],
//       shopperId: json["shopperId"] == null
//           ? []
//           : List<ShopperIdModel>.from(
//               json["shopperId"]!.map((x) => ShopperIdModel.fromJson(x))),
//       commentCount: json["commentCount"],
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "title": title,
//         "content": content,
//         "shopperId": shopperId.map((x) => x.toJson()).toList(),
//         "commentCount": commentCount,
//         "createdAt": createdAt?.toIso8601String(),
//       };
// }

// class ShopperIdModel extends ShopperIdEnitiy {
//   ShopperIdModel({
//     required this.id,
//     required this.email,
//     required this.city,
//     required this.eventName,
//     required this.image,
//   }) : super(
//           id: id,
//           email: email,
//           city: city,
//           eventName: eventName,
//           image: image,
//         );

//   final String? id;
//   final String? email;
//   final String? city;
//   final String? eventName;
//   final String? image;

//   factory ShopperIdModel.fromJson(Map<String, dynamic> json) {
//     return ShopperIdModel(
//       id: json["_id"],
//       email: json["email"],
//       city: json["city"],
//       eventName: json["event_name"],
//       image: json["image"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "email": email,
//         "city": city,
//         "event_name": eventName,
//         "image": image,
//       };
// }
class ReportGetAllPostsModle {
  ReportGetAllPostsModle({
    required this.success,
    required this.message,
    required this.dataPost,
  });

  final bool? success;
  final String? message;
  final List<DataGetAllPostModel> dataPost;

  factory ReportGetAllPostsModle.fromJson(Map<String, dynamic> json) {
    return ReportGetAllPostsModle(
      success: json["success"],
      message: json["message"],
      dataPost: json["DataPost"] == null
          ? []
          : List<DataGetAllPostModel>.from(
              json["DataPost"]!.map((x) => DataGetAllPostModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "DataPost": dataPost.map((x) => x.toJson()).toList(),
      };
}

class DataGetAllPostModel {
  DataGetAllPostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.shopperId,
    required this.images,
    required this.commentCount,
    required this.createdAt,
  });

  final String? id;
  final String? title;
  final String? content;
  final List<ShopperId> shopperId;
  final List<ImagePost> images;
  final int? commentCount;
  final DateTime? createdAt;

  factory DataGetAllPostModel.fromJson(Map<String, dynamic> json) {
    return DataGetAllPostModel(
      id: json["_id"],
      title: json["title"],
      content: json["content"],
      shopperId: json["shopperId"] == null
          ? []
          : List<ShopperId>.from(
              json["shopperId"]!.map((x) => ShopperId.fromJson(x))),
      images: json["images"] == null
          ? []
          : List<ImagePost>.from(
              json["images"]!.map((x) => ImagePost.fromJson(x))),
      commentCount: json["commentCount"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
        "shopperId": shopperId.map((x) => x.toJson()).toList(),
        "images": images.map((x) => x.toJson()).toList(),
        "commentCount": commentCount,
        "createdAt": createdAt?.toIso8601String(),
      };
}

class ImagePost {
  ImagePost({
    required this.url,
    required this.id,
  });

  final String? url;
  final String? id;

  factory ImagePost.fromJson(Map<String, dynamic> json) {
    return ImagePost(
      url: json["url"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "_id": id,
      };
}

class ShopperId {
  ShopperId({
    required this.id,
    required this.eventName,
    required this.image,
  });

  final String? id;
  final String? eventName;
  final String? image;

  factory ShopperId.fromJson(Map<String, dynamic> json) {
    return ShopperId(
      id: json["_id"],
      eventName: json["event_name"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "event_name": eventName,
        "image": image,
      };
}

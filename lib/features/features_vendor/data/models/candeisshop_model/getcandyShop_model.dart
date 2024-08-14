// ignore_for_file: file_names

class GetcandyshopModel {
  GetcandyshopModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final DatacandyshopModel? data;

  factory GetcandyshopModel.fromJson(Map<String, dynamic> json) {
    return GetcandyshopModel(
      success: json["success"],
      message: json["message"],
      data: json["Data"] == null
          ? null
          : DatacandyshopModel.fromJson(json["Data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Data": data?.toJson(),
      };
}

class DatacandyshopModel {
  DatacandyshopModel({
    required this.id,
    required this.candeImage,
    required this.avargSweet,
    required this.dataOpen,
    required this.shopperId,
    required this.createdAt,
    required this.v,
  });

  final String? id;
  final List<CandeImage> candeImage;
  final int? avargSweet;
  final String? dataOpen;
  final List<String> shopperId;
  final DateTime? createdAt;
  final int? v;

  factory DatacandyshopModel.fromJson(Map<String, dynamic> json) {
    return DatacandyshopModel(
      id: json["_id"],
      candeImage: json["cande_image"] == null
          ? []
          : List<CandeImage>.from(
              json["cande_image"]!.map((x) => CandeImage.fromJson(x))),
      avargSweet: json["avarg_Sweet"],
      dataOpen: json["data_open"],
      shopperId: json["shopperId"] == null
          ? []
          : List<String>.from(json["shopperId"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "cande_image": candeImage.map((x) => x.toJson()).toList(),
        "avarg_Sweet": avargSweet,
        "data_open": dataOpen,
        "shopperId": shopperId.map((x) => x).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class CandeImage {
  CandeImage({
    required this.url,
    required this.id,
  });

  final String? url;
  final String? id;

  factory CandeImage.fromJson(Map<String, dynamic> json) {
    return CandeImage(
      url: json["url"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "_id": id,
      };
}

class Getinforestorant {
  Getinforestorant({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final DataGetinforestorant? data;

  factory Getinforestorant.fromJson(Map<String, dynamic> json) {
    return Getinforestorant(
      success: json["success"],
      message: json["message"],
      data: json["Data"] == null
          ? null
          : DataGetinforestorant.fromJson(json["Data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Data": data?.toJson(),
      };
}

class DataGetinforestorant {
  DataGetinforestorant({
    required this.id,
    required this.restImage,
    required this.allTable,
    required this.priceTable,
    required this.dataRest,
    required this.shopperId,
    required this.createdAt,
    required this.v,
  });

  final String? id;
  final List<RestImage> restImage;
  final int? allTable;
  final int? priceTable;
  final DateTime? dataRest;
  final List<String> shopperId;
  final DateTime? createdAt;
  final int? v;

  factory DataGetinforestorant.fromJson(Map<String, dynamic> json) {
    return DataGetinforestorant(
      id: json["_id"],
      restImage: json["rest_image"] == null
          ? []
          : List<RestImage>.from(
              json["rest_image"]!.map((x) => RestImage.fromJson(x))),
      allTable: json["all_table"],
      priceTable: json["price_table"],
      dataRest: DateTime.tryParse(json["data_rest"] ?? ""),
      shopperId: json["shopperId"] == null
          ? []
          : List<String>.from(json["shopperId"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "rest_image": restImage.map((x) => x.toJson()).toList(),
        "all_table": allTable,
        "price_table": priceTable,
        "data_rest":
            "${dataRest!.year.toString().padLeft(4, '0')}-${dataRest!.month.toString().padLeft(2, '0')}-${dataRest!.day.toString().padLeft(2, '0')}",
        "shopperId": shopperId.map((x) => x).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class RestImage {
  RestImage({
    required this.url,
    required this.id,
  });

  final String? url;
  final String? id;

  factory RestImage.fromJson(Map<String, dynamic> json) {
    return RestImage(
      url: json["url"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "_id": id,
      };
}

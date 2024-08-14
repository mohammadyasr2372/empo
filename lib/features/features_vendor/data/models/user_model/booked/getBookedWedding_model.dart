// ignore_for_file: file_names

class GetbookedweddingModel {
  GetbookedweddingModel({
    required this.success,
    required this.detailsBooked,
  });

  final bool? success;
  final List<DetailsBooked> detailsBooked;

  factory GetbookedweddingModel.fromJson(Map<String, dynamic> json) {
    return GetbookedweddingModel(
      success: json["success"],
      detailsBooked: json["detailsBooked"] == null
          ? []
          : List<DetailsBooked>.from(
              json["detailsBooked"]!.map((x) => DetailsBooked.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "detailsBooked": detailsBooked.map((x) => x.toJson()).toList(),
      };
}

class DetailsBooked {
  DetailsBooked({
    required this.id,
    required this.totalPrice,
    required this.numberChairBooked,
    required this.userId,
    required this.widdId,
    required this.dateBooked,
    required this.createdAt,
    required this.v,
  });

  final String? id;
  final int? totalPrice;
  final int? numberChairBooked;
  final List<UserId> userId;
  final List<String> widdId;
  final DateTime? dateBooked;
  final DateTime? createdAt;
  final int? v;

  factory DetailsBooked.fromJson(Map<String, dynamic> json) {
    return DetailsBooked(
      id: json["_id"],
      totalPrice: json["total_Price"],
      numberChairBooked: json["number_chairBooked"],
      userId: json["userId"] == null
          ? []
          : List<UserId>.from(json["userId"]!.map((x) => UserId.fromJson(x))),
      widdId: json["widdId"] == null
          ? []
          : List<String>.from(json["widdId"]!.map((x) => x)),
      dateBooked: DateTime.tryParse(json["DateBooked"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "total_Price": totalPrice,
        "number_chairBooked": numberChairBooked,
        "userId": userId.map((x) => x.toJson()).toList(),
        "widdId": widdId.map((x) => x).toList(),
        "DateBooked": dateBooked?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class UserId {
  UserId({
    required this.id,
    required this.name,
    required this.email,
  });

  final String? id;
  final String? name;
  final String? email;

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
      };
}

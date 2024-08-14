class SearchPrice {
  SearchPrice({
    required this.success,
    required this.message,
    required this.data,
    required this.page,
    required this.nextPage,
    required this.totalPages,
    required this.totalShopper,
  });

  final bool? success;
  final String? message;
  final List<DataShopper> data;
  final int? page;
  final int? nextPage;
  final int? totalPages;
  final int? totalShopper;

  factory SearchPrice.fromJson(Map<String, dynamic> json) {
    return SearchPrice(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<DataShopper>.from(
              json["data"]!.map((x) => DataShopper.fromJson(x))),
      page: json["page"],
      nextPage: json["nextPage"],
      totalPages: json["totalPages"],
      totalShopper: json["totalShopper"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
        "page": page,
        "nextPage": nextPage,
        "totalPages": totalPages,
        "totalShopper": totalShopper,
      };
}

class DataShopper {
  DataShopper({
    required this.id,
    required this.shopperId,
  });

  final String? id;
  final List<String> shopperId;

  factory DataShopper.fromJson(Map<String, dynamic> json) {
    return DataShopper(
      id: json["_id"],
      shopperId: json["shopperId"] == null
          ? []
          : List<String>.from(json["shopperId"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "shopperId": shopperId.map((x) => x).toList(),
      };
}

class BookedWeddingUserModel {
  BookedWeddingUserModel({
    required this.dateBooked,
    required this.numberChairBooked,
  });

  final DateTime? dateBooked;
  final String? numberChairBooked;

  factory BookedWeddingUserModel.fromJson(Map<String, dynamic> json) {
    return BookedWeddingUserModel(
      dateBooked: DateTime.tryParse(json["DateBooked"] ?? ""),
      numberChairBooked: json["number_chairBooked"],
    );
  }

  Map<String, dynamic> toJson() => {
        "DateBooked":
            "${dateBooked!.year.toString().padLeft(4, '0')}-${dateBooked!.month.toString().padLeft(2, '0')}-${dateBooked!.day.toString().padLeft(2, '0')}",
        "number_chairBooked": numberChairBooked,
      };
}

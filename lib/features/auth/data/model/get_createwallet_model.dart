class GetCreatewalletModel {
  GetCreatewalletModel({
    required this.success,
    required this.message,
    required this.id,
  });

  final bool? success;
  final String? message;
  final String? id;

  factory GetCreatewalletModel.fromJson(Map<String, dynamic> json) {
    return GetCreatewalletModel(
      success: json["success"],
      message: json["message"],
      id: json["ID"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "ID": id,
      };
}

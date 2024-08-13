class GetwalletModel {
  GetwalletModel({
    required this.success,
    required this.data,
    required this.money,
  });

  final bool? success;
  final String? data;
  final int? money;

  factory GetwalletModel.fromJson(Map<String, dynamic> json) {
    return GetwalletModel(
      success: json["success"],
      data: json["data"],
      money: json["money"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
        "money": money,
      };
}

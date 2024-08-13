class PaidShopperModel {
  PaidShopperModel({
    required this.success,
    required this.msg,
    required this.datePaidMonth,
    required this.accessToken,
    required this.refreshtoken,
  });

  final bool? success;
  final String? msg;
  final DateTime? datePaidMonth;
  final String? accessToken;
  final String? refreshtoken;

  factory PaidShopperModel.fromJson(Map<String, dynamic> json) {
    return PaidShopperModel(
      success: json["success"],
      msg: json["msg"],
      datePaidMonth: DateTime.tryParse(json["DatePaidMonth"] ?? ""),
      accessToken: json["accessToken"],
      refreshtoken: json["Refreshtoken"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "DatePaidMonth": datePaidMonth?.toIso8601String(),
        "accessToken": accessToken,
        "Refreshtoken": refreshtoken,
      };
}

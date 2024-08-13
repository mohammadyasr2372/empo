class CreatechargewalletModel {
  CreatechargewalletModel({
    required this.password,
    required this.rechargeMoney,
    required this.walteId,
  });

  final String? password;
  final String? rechargeMoney;
  final String? walteId;

  factory CreatechargewalletModel.fromJson(Map<String, dynamic> json) {
    return CreatechargewalletModel(
      password: json["password"],
      rechargeMoney: json["Recharge_money"],
      walteId: json["walteId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "password": password,
        "Recharge_money": rechargeMoney,
        "walteId": walteId,
      };
}

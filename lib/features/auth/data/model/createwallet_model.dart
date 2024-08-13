class CreatewalletModel {
  final String? password;

  CreatewalletModel({
    required this.password,
  });
  Map<String, dynamic> toJson() => {
        "password": password,
      };

  factory CreatewalletModel.fromJson(Map<String, dynamic> json) {
    return CreatewalletModel(
      password: json["password"],
    );
  }
}

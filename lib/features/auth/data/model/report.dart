class ReportLocation {
  ReportLocation({
    required this.id,
    required this.num1,
    required this.num2,
    required this.created,
  });

  late final int? id;
  final String? num1;
  final String? num2;
  final DateTime? created;

  factory ReportLocation.fromJson(Map<String, dynamic> json) {
    return ReportLocation(
      id: json["id"],
      num1: json["num1"],
      num2: json["num2"],
      created: DateTime.tryParse(json["created"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "num1": num1,
        "num2": num2,
        "created": created?.toIso8601String(),
      };
}

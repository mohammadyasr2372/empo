class Addreport {
    Addreport({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final DataReport? data;

    factory Addreport.fromJson(Map<String, dynamic> json){ 
        return Addreport(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : DataReport.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };

}

class DataReport {
    DataReport({
        required this.reason,
        required this.createdAt,
    });

    final String? reason;
    final DateTime? createdAt;

    factory DataReport.fromJson(Map<String, dynamic> json){ 
        return DataReport(
            reason: json["reason"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "reason": reason,
        "createdAt": createdAt?.toIso8601String(),
    };

}

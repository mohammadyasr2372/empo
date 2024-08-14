class BookedResturantUserModel {
    BookedResturantUserModel({
        required this.numberTableBooked,
        required this.dateBooked,
        required this.startTime,
        required this.endTime,
    });

    final String? numberTableBooked;
    final DateTime? dateBooked;
    final String? startTime;
    final String? endTime;

    factory BookedResturantUserModel.fromJson(Map<String, dynamic> json){ 
        return BookedResturantUserModel(
            numberTableBooked: json["number_tableBooked"],
            dateBooked: DateTime.tryParse(json["DateBooked"] ?? ""),
            startTime: json["startTime"],
            endTime: json["endTime"],
        );
    }

    Map<String, dynamic> toJson() => {
        "number_tableBooked": numberTableBooked,
        "DateBooked": "${dateBooked!.year.toString().padLeft(4,'0')}-${dateBooked!.month.toString().padLeft(2,'0')}-${dateBooked!.day.toString().padLeft(2,'0')}",
        "startTime": startTime,
        "endTime": endTime,
    };

}

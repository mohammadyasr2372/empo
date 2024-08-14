class GetShopper {
    GetShopper({
        required this.success,
        required this.data,
    });

    final bool? success;
    final getDataShopper? data;

    factory GetShopper.fromJson(Map<String, dynamic> json){ 
        return GetShopper(
            success: json["success"],
            data: json["data"] == null ? null : getDataShopper.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
    };

}

class getDataShopper {
    getDataShopper({
        required this.id,
        required this.email,
        required this.city,
        required this.eventName,
        required this.image,
    });

    final String? id;
    final String? email;
    final String? city;
    final String? eventName;
    final String? image;

    factory getDataShopper.fromJson(Map<String, dynamic> json){ 
        return getDataShopper(
            id: json["_id"],
            email: json["email"],
            city: json["city"],
            eventName: json["event_name"],
            image: json["image"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "city": city,
        "event_name": eventName,
        "image": image,
    };

}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetLocationShopper {
  final String location1;
  final String location2;
  GetLocationShopper({
    required this.location1,
    required this.location2,
  });

  GetLocationShopper copyWith({
    String? location1,
    String? location2,
  }) {
    return GetLocationShopper(
      location1: location1 ?? this.location1,
      location2: location2 ?? this.location2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location1': location1,
      'location2': location2,
    };
  }

  factory GetLocationShopper.fromMap(Map<String, dynamic> map) {
    return GetLocationShopper(
      location1: map['location1'] as String,
      location2: map['location2'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetLocationShopper.fromJson(String source) => GetLocationShopper.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetLocationShopper(location1: $location1, location2: $location2)';

  @override
  bool operator ==(covariant GetLocationShopper other) {
    if (identical(this, other)) return true;
  
    return 
      other.location1 == location1 &&
      other.location2 == location2;
  }

  @override
  int get hashCode => location1.hashCode ^ location2.hashCode;
}

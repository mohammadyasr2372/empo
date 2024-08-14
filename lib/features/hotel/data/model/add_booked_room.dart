// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddBookedRoom {
  final String idRoom;
  final String number_guest;
  final String data_stay;
  final String data_leave;
  AddBookedRoom({
    required this.idRoom,
    required this.number_guest,
    required this.data_stay,
    required this.data_leave,
  });

  AddBookedRoom copyWith({
    String? idRoom,
    String? number_guest,
    String? data_stay,
    String? data_leave,
  }) {
    return AddBookedRoom(
      idRoom: idRoom ?? this.idRoom,
      number_guest: number_guest ?? this.number_guest,
      data_stay: data_stay ?? this.data_stay,
      data_leave: data_leave ?? this.data_leave,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idRoom': idRoom,
      'number_guest': number_guest,
      'data_stay': data_stay,
      'data_leave': data_leave,
    };
  }

  factory AddBookedRoom.fromMap(Map<String, dynamic> map) {
    return AddBookedRoom(
      idRoom: map['idRoom'] as String,
      number_guest: map['number_guest'] as String,
      data_stay: map['data_stay'] as String,
      data_leave: map['data_leave'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddBookedRoom.fromJson(String source) =>
      AddBookedRoom.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddBookedRoom(idRoom: $idRoom, number_guest: $number_guest, data_stay: $data_stay, data_leave: $data_leave)';
  }

  @override
  bool operator ==(covariant AddBookedRoom other) {
    if (identical(this, other)) return true;

    return other.idRoom == idRoom &&
        other.number_guest == number_guest &&
        other.data_stay == data_stay &&
        other.data_leave == data_leave;
  }

  @override
  int get hashCode {
    return idRoom.hashCode ^
        number_guest.hashCode ^
        data_stay.hashCode ^
        data_leave.hashCode;
  }
}

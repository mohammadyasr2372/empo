// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_room_bloc.dart';

sealed class GetRoomEvent extends Equatable {
  const GetRoomEvent();

  @override
  List<Object> get props => [];
}

class GetInfoHotelEvent extends GetRoomEvent {
  final String idRoom;
  const GetInfoHotelEvent({
    required this.idRoom,
  });
}

class RefreshInfoHotelEvent extends GetRoomEvent {
  final String idRoom;
  const RefreshInfoHotelEvent({
    required this.idRoom,
  });
}

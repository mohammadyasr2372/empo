part of 'get_room_bloc.dart';

sealed class GetRoomState extends Equatable {
  const GetRoomState();

  @override
  List<Object> get props => [];
}

final class GetRoomInitial extends GetRoomState {}

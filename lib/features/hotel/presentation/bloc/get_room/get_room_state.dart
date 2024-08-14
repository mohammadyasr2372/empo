part of 'get_room_bloc.dart';

sealed class GetRoomState extends Equatable {
  const GetRoomState();

  @override
  List<Object> get props => [];
}

final class GetRoomInitial extends GetRoomState {}

class LoadingGetRoomState extends GetRoomState {}

class LoadedProGetRoomState extends GetRoomState {
  final RoomGet roomGet;

  const LoadedProGetRoomState({required this.roomGet});

  @override
  List<Object> get props => [roomGet];
}

class ErrorGetRoomState extends GetRoomState {
  final String message;

  const ErrorGetRoomState({required this.message});

  @override
  List<Object> get props => [message];
}

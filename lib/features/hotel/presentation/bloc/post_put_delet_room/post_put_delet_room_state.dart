part of 'post_put_delet_room_bloc.dart';

sealed class PostPutDeletRoomState extends Equatable {
  const PostPutDeletRoomState();
  
  @override
  List<Object> get props => [];
}

final class PostPutDeletRoomInitial extends PostPutDeletRoomState {}

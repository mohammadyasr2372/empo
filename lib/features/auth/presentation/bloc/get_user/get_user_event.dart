part of 'get_user_bloc.dart';

sealed class GetUserEvent extends Equatable {
  const GetUserEvent();

  @override
  List<Object> get props => [];
}

class GetProUserEvent extends GetUserEvent {}

class RefreshProUserEvent extends GetUserEvent {}

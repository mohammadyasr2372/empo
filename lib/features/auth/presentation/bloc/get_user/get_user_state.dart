part of 'get_user_bloc.dart';

sealed class GetUserState extends Equatable {
  const GetUserState();
  
  @override
  List<Object> get props => [];
}

final class GetUserInitial extends GetUserState {}

class LoadingGetUserState extends GetUserState {}

class LoadedProGetUserState extends GetUserState {
  final User user;

  const LoadedProGetUserState({required this.user});

  @override
  List<Object> get props => [user];
}

class ErrorGetUserState extends GetUserState {
  final String message;

  const ErrorGetUserState({required this.message});

  @override
  List<Object> get props => [message];
}

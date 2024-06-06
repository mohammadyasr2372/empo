part of 'post_put_delet_user_bloc.dart';

sealed class PostPutDeletUserState extends Equatable {
  const PostPutDeletUserState();

  @override
  List<Object> get props => [];
}

final class PostPutDeletUserInitial extends PostPutDeletUserState {}

class LoadingPostPutDeletUserState extends PostPutDeletUserState {}

class ErrorPostPutDeletUserState extends PostPutDeletUserState {
  final String message;

  const ErrorPostPutDeletUserState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessagePostPutDeletUserState extends PostPutDeletUserState {
  final String message;

  const MessagePostPutDeletUserState({required this.message});

  @override
  List<Object> get props => [message];
}

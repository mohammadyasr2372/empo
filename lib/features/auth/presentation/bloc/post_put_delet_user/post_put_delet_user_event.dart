part of 'post_put_delet_user_bloc.dart';

sealed class PostPutDeletUserEvent extends Equatable {
  const PostPutDeletUserEvent();

  @override
  List<Object> get props => [];
}

class LoginUserEvent extends PostPutDeletUserEvent {
  final User user;

  const LoginUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterUserEvent extends PostPutDeletUserEvent {
  final User user;

  const RegisterUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class UpdateUserEvent extends PostPutDeletUserEvent {
  final User user;

  const UpdateUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class ChangeMyPasswordUserEvent extends PostPutDeletUserEvent {
  final User user;

  const ChangeMyPasswordUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class DeleteUserEvent extends PostPutDeletUserEvent {}

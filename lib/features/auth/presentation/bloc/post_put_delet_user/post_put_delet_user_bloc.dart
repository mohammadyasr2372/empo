// ignore_for_file: type_literal_in_constant_pattern, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecase/user.dart';

part 'post_put_delet_user_event.dart';
part 'post_put_delet_user_state.dart';

class PostPutDeletUserBloc
    extends Bloc<PostPutDeletUserEvent, PostPutDeletUserState> {
  LoginUserUseCase loginUserUseCase;
  RegisterUserUseCase registerUserUseCase;
  DeleteUserUseCase deleteUserUseCase;
  UpdataUserUseCase updataUserUseCase;
  ChangeMyPasswordUserUseCase changeMyPasswordUserUseCase;
  PostPutDeletUserBloc(
      {required this.loginUserUseCase,
      required this.registerUserUseCase,
      required this.updataUserUseCase,
      required this.deleteUserUseCase,
      required this.changeMyPasswordUserUseCase})
      : super(PostPutDeletUserInitial()) {
    on<PostPutDeletUserEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        emit(LoadingPostPutDeletUserState());

        final failureOrDoneMessage = await loginUserUseCase(event.user);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
        );
      } else if (event is UpdateUserEvent) {
        emit(LoadingPostPutDeletUserState());

        final failureOrDoneMessage = await updataUserUseCase(event.user);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } else if (event is RegisterUserEvent) {
        emit(LoadingPostPutDeletUserState());

        final failureOrDoneMessage = await registerUserUseCase(event.user);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } else if (event is DeleteUserEvent) {
        emit(LoadingPostPutDeletUserState());

        final failureOrDoneMessage = await deleteUserUseCase();

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, DELETE_SUCCESS_MESSAGE),
        );
      }
    });
  }
  PostPutDeletUserState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorPostPutDeletUserState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessagePostPutDeletUserState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}

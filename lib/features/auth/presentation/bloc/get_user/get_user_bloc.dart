// ignore_for_file: depend_on_referenced_packages, type_literal_in_constant_pattern

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecase/user.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  final GetProUserUseCase getProUserUseCase;
  GetUserBloc({required this.getProUserUseCase}) : super(GetUserInitial()) {
    on<GetUserEvent>((event, emit) async {
      if (event is GetProUserEvent) {
        emit(LoadingGetUserState());

        final failureOrUser = await getProUserUseCase();
        emit(_mapFailureOrUserToState(failureOrUser));
      } else if (event is RefreshProUserEvent) {
        emit(LoadingGetUserState());

        final failureOrUsers = await getProUserUseCase();
        emit(_mapFailureOrUserToState(failureOrUsers));
      }
    });
  }

  GetUserState _mapFailureOrUserToState(Either<Failure, User> either) {
    return either.fold(
      (failure) => ErrorGetUserState(message: _mapFailureToMessage(failure)),
      (user) => LoadedProGetUserState(
        user: user,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}

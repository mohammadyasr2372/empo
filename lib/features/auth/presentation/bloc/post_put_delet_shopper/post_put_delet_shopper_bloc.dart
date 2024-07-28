// ignore_for_file: type_literal_in_constant_pattern, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/shopper_entity.dart';
import '../../../domain/usecase/shopper.dart';

part 'post_put_delet_shopper_event.dart';
part 'post_put_delet_shopper_state.dart';

class PostPutDeletShopperBloc
    extends Bloc<PostPutDeletShopperEvent, PostPutDeletShopperState> {
  LoginShopperUseCase loginShopperUseCase;
  RegisterShopperUseCase registerShopperUseCase;
  DeleteShopperUseCase deleteShopperUseCase;
  UpdataShopperUseCase updataShopperUseCase;
  ChangeMyPasswordShopperUseCase changeMyPasswordShopperUseCase;
  PostPutDeletShopperBloc(
      {required this.loginShopperUseCase,
      required this.registerShopperUseCase,
      required this.updataShopperUseCase,
      required this.deleteShopperUseCase,
      required this.changeMyPasswordShopperUseCase})
      : super(PostPutDeletShopperInitial()) {
    on<PostPutDeletShopperEvent>((event, emit) async {
      if (event is LoginShopperEvent) {
        emit(LoadingPostPutDeletShopperState());

        final failureOrDoneMessage = await loginShopperUseCase(event.shopper);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
        );
      } else if (event is RegisterShopperEvent) {
        emit(LoadingPostPutDeletShopperState());

        final failureOrDoneMessage =
            await registerShopperUseCase(event.shopper);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } else if (event is UpdateShopperEvent) {
        emit(LoadingPostPutDeletShopperState());

        final failureOrDoneMessage = await updataShopperUseCase(event.shopper);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } else if (event is DeleteShopperEvent) {
        emit(LoadingPostPutDeletShopperState());

        final failureOrDoneMessage = await deleteShopperUseCase();

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, DELETE_SUCCESS_MESSAGE),
        );
      }
    });
  }
  PostPutDeletShopperState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorPostPutDeletShopperState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessagePostPutDeletShopperState(message: message),
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

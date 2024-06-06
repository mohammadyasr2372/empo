
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../../core/resources/data_state.dart';
// import '../../../../domain/usecase/user.dart';
// import 'user_event.dart';
// import 'user_state.dart';

// class UserBloc extends Bloc<UserEvent, UserState> {
//   final LoginUserUseCase _loginUserUseCase;
//   final RegisterUserUseCase _registerUserUseCase;
//   final GetUserUseCase _getUserUseCase;
//   final DeleteUserUseCase _deleteUserUseCase;
//   final UpdataUserUseCase _updataUserUseCase;
//   final GetProUserUseCase _getProUserUseCase;
//   final ChangeMyPasswordUserUseCase _changeMyPasswordUserUseCase;

//   UserBloc(
//       this._loginUserUseCase,
//       this._registerUserUseCase,
//       this._getUserUseCase,
//       this._deleteUserUseCase,
//       this._updataUserUseCase,
//       this._getProUserUseCase,
//       this._changeMyPasswordUserUseCase)
//       : super(const UserInitState()) {
//     on<LoginUser>(onLoginUser);
//     on<RegisterUser>(onRegisterUser);
//     on<GetUser>(onGetUser);
//     on<DeleteUser>(onDeleteUser);
//     on<UpdataProUser>(onUpdataProUser);
//     on<GetPro>(onGetPro);
//     on<ChangeMyPassword>(onChangeMyPassword);
//   }

//   void onLoginUser(LoginUser event, Emitter<UserState> emit) async {
//     emit(const UserLoadingState());

//     final dataState = await _loginUserUseCase(params: event.userEntity);

//     if (dataState is DataSuccess) {
//       emit(LoginUserDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(UserErrorState(dataState.exception!));
//     }
//   }

//   void onRegisterUser(RegisterUser event, Emitter<UserState> emit) async {
//     emit(const UserLoadingState());

//     final dataState = await _registerUserUseCase(params: event.userEntity);

//     if (dataState is DataSuccess) {
//       emit(RegisterUserDoneState(dataState.data! ));
//     }

//     if (dataState is DataFailed) {
//       emit(UserErrorState(dataState.exception!));
//     }
//   }

//   void onGetUser(GetUser event, Emitter<UserState> emit) async {
//     emit(const UserLoadingState());

//     final dataState = await _getUserUseCase();

//     if (dataState is DataSuccess) {
//       emit(GetUserDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(UserErrorState(dataState.exception!));
//     }
//   }

//   void onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
//     emit(const UserLoadingState());

//     final dataState = await _deleteUserUseCase();

//     if (dataState is DataSuccess) {
//       emit(DeleteUserDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(UserErrorState(dataState.exception!));
//     }
//   }

//   void onUpdataProUser(UpdataProUser event, Emitter<UserState> emit) async {
//     emit(const UserLoadingState());

//     final dataState = await _updataUserUseCase(params: event.userEntity);

//     if (dataState is DataSuccess) {
//       emit(UpdataProUserDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(UserErrorState(dataState.exception!));
//     }
//   }

//   void onGetPro(GetPro event, Emitter<UserState> emit) async {
//     emit(const UserLoadingState());

//     final dataState = await _getProUserUseCase();

//     if (dataState is DataSuccess) {
//       emit(GetProUserDoneState(dataState.data! ));
//     }

//     if (dataState is DataFailed) {
//       emit(UserErrorState(dataState.exception!));
//     }
//   }

//   void onChangeMyPassword(
//       ChangeMyPassword event, Emitter<UserState> emit) async {
//     emit(const UserLoadingState());

//     final dataState =
//         await _changeMyPasswordUserUseCase(params: event.userEntity);

//     if (dataState is DataSuccess) {
//       emit(ChangeMyPasswordUserDoneState(dataState.data! ));
//     }

//     if (dataState is DataFailed) {
//       emit(UserErrorState(dataState.exception!));
//     }
//   }
// }

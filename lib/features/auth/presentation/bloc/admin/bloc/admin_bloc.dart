// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../../core/resources/data_state.dart';
// import '../../../../domain/usecase/admin.dart';
// import 'admin_event.dart';
// import 'admin_state.dart';

// class AdminBloc extends Bloc<AdminEvent, AdminState> {
//   final LoginAdminUseCase _loginAdminUseCase;
//   final GetUsersWithAdminUseCase _getUsersWithAdminUseCase;
//   final GetAllUsersUseCase _getAllUsersUseCase;
//   final SearchUsersUseCase _searchUsersUseCase;
//   final SearchShoppersUseCase _searchShoppersUseCase;
//   final GetAllShoppersUseCase _getAllShoppersUseCase;
//   final GetShoppersWithAdminUseCase _getShoppersWithAdminUseCase;
//   final ChangeMyPasswordAdminUseCase _changeMyPasswordAdminUseCase;
//   final UpdateProAdminUseCase _updateProAdminUseCase;
//   final GetProAdminUseCase _getProAdminUseCase;
//   final DeleteUserAdminUseCase _deleteUserAdminUseCase;
//   final GetCounterUsersUseCase _getCounterUsersUseCase;
//   final GetCounterShoppersUseCase _getCounterShoppersUseCase;

//   AdminBloc(
//       this._loginAdminUseCase,
//       this._getUsersWithAdminUseCase,
//       this._getAllUsersUseCase,
//       this._searchUsersUseCase,
//       this._searchShoppersUseCase,
//       this._getAllShoppersUseCase,
//       this._getShoppersWithAdminUseCase,
//       this._changeMyPasswordAdminUseCase,
//       this._updateProAdminUseCase,
//       this._getProAdminUseCase,
//       this._deleteUserAdminUseCase,
//       this._getCounterUsersUseCase,
//       this._getCounterShoppersUseCase)
//       : super(const AdminInitState()) {
//     on<LoginAdmin>(onLoginAdmin);
//     on<GetUserWithAdmin>(onGetUsersWithAdmin);
//     on<GetAllUser>(onGetAllUsers);
//     on<SearchUser>(onSearchUsers);
//     on<SearchShoppers>(onSearchShoppers);
//     on<GetShopperWithAdmin>(onGetShoppersWithAdmin);
//     on<GetAllShopper>(onGetAllShoppers);
//     on<ChangeMyPasswordAdmin>(onChangeMyPasswordAdmin);
//     on<DeleteUserAdmin>(onDeleteUserAdmin);
//     on<UpdataProAdmin>(onUpdateProAdmin);
//     on<GetProAdmin>(onGetProAdmin);
//     on<GetCounterUsers>(onGetCounterUsers);
//     on<GetCounterUsers>(onGetCounterUsers);
//   }

//   void onLoginAdmin(LoginAdmin event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _loginAdminUseCase(params: event.admin);

//     if (dataState is DataSuccess) {
//       emit(LoginAdminDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }

//   void onChangeMyPasswordAdmin(
//       ChangeMyPasswordAdmin event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _changeMyPasswordAdminUseCase(params: event.admin);

//     if (dataState is DataSuccess) {
//       emit(ChangeMyPasswordAdminDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }

//   void onUpdateProAdmin(UpdataProAdmin event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _updateProAdminUseCase(params: event.admin);

//     if (dataState is DataSuccess) {
//       emit(UpdataProAdminDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }

//   void onGetUsersWithAdmin(
//       GetUserWithAdmin event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _getUsersWithAdminUseCase();

//     if (dataState is DataSuccess) {
//       emit(GetUserWithAdminDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }

//   void onGetAllUsers(GetAllUser event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _getAllUsersUseCase();

//     if (dataState is DataSuccess) {
//       emit(GetAllUserDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }

//   void onGetProAdmin(GetProAdmin event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _getProAdminUseCase();

//     if (dataState is DataSuccess) {
//       emit(GetProAdminDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }

//   void onSearchUsers(SearchUser event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _searchUsersUseCase();

//     if (dataState is DataSuccess) {
//       emit(SearchUserDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }

//   void onSearchShoppers(SearchShoppers event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _searchShoppersUseCase();

//     if (dataState is DataSuccess) {
//       emit(SearchShoppersDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }

//   void onGetAllShoppers(GetAllShopper event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _getAllShoppersUseCase();

//     if (dataState is DataSuccess) {
//       emit(GetAllShopperDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }

//   void onGetShoppersWithAdmin(
//       GetShopperWithAdmin event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _getShoppersWithAdminUseCase();

//     if (dataState is DataSuccess) {
//       emit(GetShopperWithAdminDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }

//   void onDeleteUserAdmin(
//       DeleteUserAdmin event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _deleteUserAdminUseCase();

//     if (dataState is DataSuccess) {
//       emit(DeleteUserAdminDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }

//   void onGetCounterUsers(
//       GetCounterUsers event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _getCounterUsersUseCase();

//     if (dataState is DataSuccess) {
//       emit(GetCounterUsersDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }

//   void onGetCounterShoppers(
//       GetCounterShoppers event, Emitter<AdminState> emit) async {
//     emit(const AdminLoadingState());

//     final dataState = await _getCounterShoppersUseCase();

//     if (dataState is DataSuccess) {
//       emit(GetCounterShoppersDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(AdminErrorState(dataState.exception!));
//     }
//   }
// }

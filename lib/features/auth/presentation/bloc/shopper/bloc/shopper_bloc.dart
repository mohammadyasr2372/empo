// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../../core/resources/data_state.dart';
// import '../../../../domain/usecase/shopper.dart';
// import 'shopper_event.dart';
// import 'shopper_state.dart';

// class ShopperBloc extends Bloc<ShopperEvent, ShopperState> {
//   final LoginShopperUseCase _loginShopperUseCase;
//   final RegisterShopperUseCase _registerShopperUseCase;
//   final DeleteShopperUseCase _deleteShopperUseCase;
//   final UpdataShopperUseCase _updataShopperUseCase;
//   final GetProShopperUseCase _getProShopperUseCase;
//   final ChangeMyPasswordShopperUseCase _changeMyPasswordShopperUseCase;
//   final ChangeMylocationShopperUseCase _changeMylocationShopperUseCase;
//   final ChangeEventNameShopperUseCase _changeEventNameShopperUseCase;

//   final InformationDataWithEventUseCase _informationDataWithEventUseCase;
//   final GetLocationShopperUseCase _getLocationShopperUseCase;

//   ShopperBloc(
//       this._loginShopperUseCase,
//       this._registerShopperUseCase,
//       this._deleteShopperUseCase,
//       this._updataShopperUseCase,
//       this._getProShopperUseCase,
//       this._changeMyPasswordShopperUseCase,
//       this._changeMylocationShopperUseCase,
//       this._informationDataWithEventUseCase,
//       this._getLocationShopperUseCase, this._changeEventNameShopperUseCase)
//       : super(const ShopperInitState()) {
//     on<LoginShopper>(onLoginShopper);
//     on<RegisterShopper>(onRegisterShopper);
//     on<DeleteShopper>(onDeleteShopper);
//     on<UpdataProShopper>(onUpdataProShopper);
//     on<GetProShopper>(onGetPro);
//     on<ChangeMyPasswordShopper>(onChangeMyPasswordShopper);
//   }

//   void onLoginShopper(LoginShopper event, Emitter<ShopperState> emit) async {
//     emit(const ShopperLoadingState());

//     final dataState = await _loginShopperUseCase(params: event.shopper);

//     if (dataState is DataSuccess) {
//       emit(LoginShopperDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(ShopperErrorState(dataState.exception!));
//     }
//   }

//   void onRegisterShopper(
//       RegisterShopper event, Emitter<ShopperState> emit) async {
//     emit(const ShopperLoadingState());

//     final dataState =
//         await _registerShopperUseCase(params: event.shopperEntity);

//     if (dataState is DataSuccess) {
//       emit(RegisterShopperDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(ShopperErrorState(dataState.exception!));
//     }
//   } void onInformationDataWithEvent(
//       InformationDataWithEventShopper event, Emitter<ShopperState> emit) async {
//     emit(const ShopperLoadingState());

//     final dataState =
//         await _informationDataWithEventUseCase(params: event.shopperEntity);

//     if (dataState is DataSuccess) {
//       emit(InformationDataWithEventShopperDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(ShopperErrorState(dataState.exception!));
//     }
//   }

//   void onGetLocationShopperUseCase(
//       GetLocationShopperUseCase event, Emitter<ShopperState> emit) async {
//     emit(const ShopperLoadingState());

//     final dataState = await _getLocationShopperUseCase();

//     if (dataState is DataSuccess) {
//       emit(GetMylocationDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(ShopperErrorState(dataState.exception!));
//     }
//   }

//   void onDeleteShopper(DeleteShopper event, Emitter<ShopperState> emit) async {
//     emit(const ShopperLoadingState());

//     final dataState = await _deleteShopperUseCase();

//     if (dataState is DataSuccess) {
//       emit(DeleteShopperDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(ShopperErrorState(dataState.exception!));
//     }
//   }

//   void onUpdataProShopper(
//       UpdataProShopper event, Emitter<ShopperState> emit) async {
//     emit(const ShopperLoadingState());

//     final dataState = await _updataShopperUseCase(params: event.shopperEntity);

//     if (dataState is DataSuccess) {
//       emit(UpdataProShopperDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(ShopperErrorState(dataState.exception!));
//     }
//   }

//   void onGetPro(GetProShopper event, Emitter<ShopperState> emit) async {
//     emit(const ShopperLoadingState());

//     final dataState = await _getProShopperUseCase();

//     if (dataState is DataSuccess) {
//       emit(GetProShopperDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(ShopperErrorState(dataState.exception!));
//     }
//   }

//   void onChangeMyPasswordShopper(
//       ChangeMyPasswordShopper event, Emitter<ShopperState> emit) async {
//     emit(const ShopperLoadingState());

//     final dataState =
//         await _changeMyPasswordShopperUseCase(params: event.shopperEntity);

//     if (dataState is DataSuccess) {
//       emit(ChangeMyPasswordShopperDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(ShopperErrorState(dataState.exception!));
//     }
//   }

//   void onChangeMylocationShopper(
//       ChangeMylocationShopper event, Emitter<ShopperState> emit) async {
//     emit(const ShopperLoadingState());

//     final dataState =
//         await _changeMylocationShopperUseCase(params: event.location);

//     if (dataState is DataSuccess) {
//       emit(ChangeMylocationShopperDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(ShopperErrorState(dataState.exception!));
//     }
//   }void onChangeEventNameShopper(
//       ChangeEventNameShopper event, Emitter<ShopperState> emit) async {
//     emit(const ShopperLoadingState());

//     final dataState =
//         await _changeEventNameShopperUseCase(params: event.location);

//     if (dataState is DataSuccess) {
//       emit(ChangeEventNameShopperDoneState(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(ShopperErrorState(dataState.exception!));
//     }
//   }
// }

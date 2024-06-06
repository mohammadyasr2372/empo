// import 'package:dio/dio.dart';
// import 'package:equatable/equatable.dart';

// import '../../../../domain/entities/shopper_entity.dart';

// abstract class ShopperState extends Equatable {
//   final ShopperEntity? shopper;
//   final String? massege;

//   final DioException? exception;
//   const ShopperState({
//     this.shopper,
//     this.massege,
//     this.exception,
//   });

//   @override
//   List<Object?> get props => [shopper, massege, exception];
// }

// class ShopperInitState extends ShopperState {
//   const ShopperInitState();
// }

// class ShopperLoadingState extends ShopperState {
//   const ShopperLoadingState();
// }

// class ShopperErrorState extends ShopperState {
//   const ShopperErrorState(DioException exception) : super(exception: exception);
// }

// class LoginShopperDoneState extends ShopperState {
//   const LoginShopperDoneState(ShopperEntity shopper) : super(shopper: shopper);
// }

// class RegisterShopperDoneState extends ShopperState {
//   const RegisterShopperDoneState(ShopperEntity shopper)
//       : super(shopper: shopper);
// }

// class DeleteShopperDoneState extends ShopperState {
//   const DeleteShopperDoneState(String massege) : super(massege: massege);
// }

// class UpdataProShopperDoneState extends ShopperState {
//   const UpdataProShopperDoneState(ShopperEntity shopper)
//       : super(shopper: shopper);
// }

// class GetProShopperDoneState extends ShopperState {
//   const GetProShopperDoneState(ShopperEntity shopper) : super(shopper: shopper);
// }

// class GetMylocationDoneState extends ShopperState {
//   const GetMylocationDoneState(String massage) : super(massege: massage);
// }

// class ChangeMyPasswordShopperDoneState extends ShopperState {
//   const ChangeMyPasswordShopperDoneState(ShopperEntity shopper)
//       : super(shopper: shopper);
// }

// class ChangeMylocationShopperDoneState extends ShopperState {
//   const ChangeMylocationShopperDoneState(ShopperEntity shopper)
//       : super(shopper: shopper);
// }

// class ChangeEventNameShopperDoneState extends ShopperState {
//   const ChangeEventNameShopperDoneState(ShopperEntity shopper)
//       : super(shopper: shopper);
// }

// class InformationDataWithEventShopperDoneState extends ShopperState {
//   const InformationDataWithEventShopperDoneState(ShopperEntity shopper)
//       : super(shopper: shopper);
// }

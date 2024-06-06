
// import 'package:dio/dio.dart';
// import 'package:equatable/equatable.dart';

// import '../../../../domain/entities/admin_entity.dart';
// import '../../../../domain/entities/shopper_entity.dart';
// import '../../../../domain/entities/user_entity.dart';

// abstract class AdminState extends Equatable {
//   final List<UserEntity?>? users;
//   final List<ShopperEntity?>? shoppers;
//   final AdminEntity? admin;
//   final String? massege;

//   final DioException? exception;
//   const AdminState({
//     this.users,
//     this.shoppers,
//     this.admin,
//     this.massege,
//     this.exception,
//   });

//   @override
//   List<Object?> get props => [admin, massege, exception];
// }

// class AdminInitState extends AdminState {
//   const AdminInitState();
// }

// class AdminLoadingState extends AdminState {
//   const AdminLoadingState();
// }

// class AdminErrorState extends AdminState {
//   const AdminErrorState(DioException exception) : super(exception: exception);
// }

// class LoginAdminDoneState extends AdminState {
//   const LoginAdminDoneState(AdminEntity admin) : super(admin: admin);
// }

// class GetUserWithAdminDoneState extends AdminState {
//   const GetUserWithAdminDoneState(List<UserEntity> users) : super(users: users);
// }

// class GetAllUserDoneState extends AdminState {
//   const GetAllUserDoneState(List<UserEntity> users) : super(users: users);
// }

// class SearchUserDoneState extends AdminState {
//   const SearchUserDoneState(List<UserEntity> users)
//       : super(users: users);
// }

// class SearchShoppersDoneState extends AdminState {
//   const SearchShoppersDoneState(List<ShopperEntity> shoppers) : super(shoppers: shoppers);
// }

// class GetShopperWithAdminDoneState extends AdminState {
//   const GetShopperWithAdminDoneState(List<ShopperEntity> shoppers)
//       : super(shoppers: shoppers);
// }

// class GetAllShopperDoneState extends AdminState {
//   const GetAllShopperDoneState(List<ShopperEntity> shoppers)
//       : super(shoppers: shoppers);
// }

// class ChangeMyPasswordAdminDoneState extends AdminState {
//   const ChangeMyPasswordAdminDoneState(AdminEntity admin) : super(admin: admin);
// }

// class DeleteUserAdminDoneState extends AdminState {
//   const DeleteUserAdminDoneState(String massege) : super(massege: massege);
// }

// class UpdataProAdminDoneState extends AdminState {
//   const UpdataProAdminDoneState(AdminEntity admin) : super(admin: admin);
// }

// class GetProAdminDoneState extends AdminState {
//   const GetProAdminDoneState(AdminEntity admin) : super(admin: admin);
// }

// class GetCounterUsersDoneState extends AdminState {
//   const GetCounterUsersDoneState(String massege) : super(massege: massege);
// }

// class GetCounterShoppersDoneState extends AdminState {
//   const GetCounterShoppersDoneState(String massege) : super(massege: massege);
// }

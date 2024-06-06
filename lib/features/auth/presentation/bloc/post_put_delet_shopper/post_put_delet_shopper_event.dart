part of 'post_put_delet_shopper_bloc.dart';

sealed class PostPutDeletShopperEvent extends Equatable {
  const PostPutDeletShopperEvent();

  @override
  List<Object> get props => [];
}

class LoginShopperEvent extends PostPutDeletShopperEvent {
  final Shopper shopper;

  const LoginShopperEvent({required this.shopper});

  @override
  List<Object> get props => [shopper];
}

class RegisterShopperEvent extends PostPutDeletShopperEvent {
  final Shopper shopper;

  const RegisterShopperEvent({required this.shopper});

  @override
  List<Object> get props => [shopper];
}

class UpdateShopperEvent extends PostPutDeletShopperEvent {
  final Shopper shopper;

  const UpdateShopperEvent({required this.shopper});

  @override
  List<Object> get props => [Shopper];
}

class ChangeMyPasswordShopperEvent extends PostPutDeletShopperEvent {
  final Shopper shopper;

  const ChangeMyPasswordShopperEvent({required this.shopper});

  @override
  List<Object> get props => [Shopper];
}

class DeleteShopperEvent extends PostPutDeletShopperEvent {}

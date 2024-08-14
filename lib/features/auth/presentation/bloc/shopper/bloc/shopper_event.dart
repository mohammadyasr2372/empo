part of 'shopper_bloc.dart';

sealed class GetShopperEvent extends Equatable {
  const GetShopperEvent();

  @override
  List<Object> get props => [];
}

class GetProShopperEvent extends GetShopperEvent {}

class RefreshProShopperEvent extends GetShopperEvent {}

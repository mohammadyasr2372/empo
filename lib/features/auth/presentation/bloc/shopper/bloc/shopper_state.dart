part of 'shopper_bloc.dart';

sealed class GetShopperState extends Equatable {
  const GetShopperState();

  @override
  List<Object> get props => [];
}

final class GetShopperInitial extends GetShopperState {}

class LoadingGetShopperState extends GetShopperState {}

class LoadedProGetShopperState extends GetShopperState {
  final GetProShopperModel getProShopperModel;

  const LoadedProGetShopperState({required this.getProShopperModel});

  @override
  List<Object> get props => [getProShopperModel];
}

class ErrorGetShopperState extends GetShopperState {
  final String message;

  const ErrorGetShopperState({required this.message});

  @override
  List<Object> get props => [message];
}

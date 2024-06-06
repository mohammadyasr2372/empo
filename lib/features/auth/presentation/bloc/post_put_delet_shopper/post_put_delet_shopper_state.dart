part of 'post_put_delet_shopper_bloc.dart';

sealed class PostPutDeletShopperState extends Equatable {
  const PostPutDeletShopperState();
  
  @override
  List<Object> get props => [];
}

final class PostPutDeletShopperInitial extends PostPutDeletShopperState {}

class LoadingPostPutDeletShopperState extends PostPutDeletShopperState {}

class ErrorPostPutDeletShopperState extends PostPutDeletShopperState {
  final String message;

  const ErrorPostPutDeletShopperState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessagePostPutDeletShopperState extends PostPutDeletShopperState {
  final String message;

  const MessagePostPutDeletShopperState({required this.message});

  @override
  List<Object> get props => [message];
}

part of 'get_hotel_bloc.dart';

sealed class GetHotelState extends Equatable {
  const GetHotelState();

  @override
  List<Object> get props => [];
}

final class GetHotelInitial extends GetHotelState {}

class LoadingGetHotelState extends GetHotelState {}

class LoadedProGetHotelState extends GetHotelState {
  final HotelInfo hotelInfo;

  const LoadedProGetHotelState({required this.hotelInfo});

  @override
  List<Object> get props => [hotelInfo];
}

class ErrorGetHotelState extends GetHotelState {
  final String message;

  const ErrorGetHotelState({required this.message});

  @override
  List<Object> get props => [message];
}

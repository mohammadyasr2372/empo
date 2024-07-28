part of 'get_hotel_bloc.dart';

sealed class GetHotelState extends Equatable {
  const GetHotelState();
  
  @override
  List<Object> get props => [];
}

final class GetHotelInitial extends GetHotelState {}

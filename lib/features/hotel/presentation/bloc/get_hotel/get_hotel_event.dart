// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors_in_immutables
part of 'get_hotel_bloc.dart';

sealed class GetHotelEvent extends Equatable {
  const GetHotelEvent();

  @override
  List<Object> get props => [];
}

class GetInfoHotelEvent extends GetHotelEvent {
  final String id;
  GetInfoHotelEvent({
    required this.id,
  });
}

class RefreshInfoHotelEvent extends GetHotelEvent {}

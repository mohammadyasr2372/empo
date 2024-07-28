import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_hotel_event.dart';
part 'get_hotel_state.dart';

class GetHotelBloc extends Bloc<GetHotelEvent, GetHotelState> {
  GetHotelBloc() : super(GetHotelInitial()) {
    on<GetHotelEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

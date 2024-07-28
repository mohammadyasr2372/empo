import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_room_event.dart';
part 'get_room_state.dart';

class GetRoomBloc extends Bloc<GetRoomEvent, GetRoomState> {
  GetRoomBloc() : super(GetRoomInitial()) {
    on<GetRoomEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

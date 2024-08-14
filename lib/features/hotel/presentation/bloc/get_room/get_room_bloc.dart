import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../injection_container.dart';
import '../../../data/data_sources/remote/room_api_service.dart';
import '../../../data/model/room_get.dart';

part 'get_room_event.dart';
part 'get_room_state.dart';

class GetRoomBloc extends Bloc<GetRoomEvent, GetRoomState> {
  GetRoomBloc() : super(GetRoomInitial()) {
    on<GetRoomEvent>((event, emit) async {
      if (event is GetInfoHotelEvent) {
        emit(LoadingGetRoomState());
        RoomGet room = await sl<RoomApiService>().getMyRoom(id: event.idRoom);
        emit(LoadedProGetRoomState(roomGet: room));
      } else if (event is RefreshInfoHotelEvent) {
        emit(LoadingGetRoomState());
        RoomGet room = await sl<RoomApiService>().getMyRoom(id: event.idRoom);
        emit(LoadedProGetRoomState(roomGet: room));
      }
    });
  }
}

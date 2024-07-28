import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_put_delet_room_event.dart';
part 'post_put_delet_room_state.dart';

class PostPutDeletRoomBloc extends Bloc<PostPutDeletRoomEvent, PostPutDeletRoomState> {
  PostPutDeletRoomBloc() : super(PostPutDeletRoomInitial()) {
    on<PostPutDeletRoomEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

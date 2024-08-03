import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_put_delet_hotel_event.dart';
part 'post_put_delet_hotel_state.dart';

class PostPutDeletHotelBloc
    extends Bloc<PostPutDeletHotelEvent, PostPutDeletHotelState> {
  PostPutDeletHotelBloc() : super(PostPutDeletHotelInitial()) {
    on<PostPutDeletHotelEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

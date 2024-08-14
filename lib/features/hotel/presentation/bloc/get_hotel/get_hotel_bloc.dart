// ignore_for_file: type_literal_in_constant_pattern, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../injection_container.dart';
import '../../../data/data_sources/remote/room_api_service.dart';
import '../../../data/data_sources/remote/widd_api_service.dart';
import '../../../data/model/get_widd_model.dart';
import '../../../data/model/image_room_model.dart';
import '../../../domain/entities/hotel_info.dart';
import '../../../domain/entities/room_short.dart';
import '../../../domain/entities/room_type.dart';

part 'get_hotel_event.dart';
part 'get_hotel_state.dart';

class GetHotelBloc extends Bloc<GetHotelEvent, GetHotelState> {
  GetHotelBloc() : super(GetHotelInitial()) {
    on<GetHotelEvent>((event, emit) async {
      if (event is GetInfoHotelEvent) {
        emit(LoadingGetHotelState());
        try {
          final List<RoomShort> superDeluxeRoomImages = [];
          final List<RoomShort> vipRoomImages = [];
          final List<RoomShort> deluxeRoomImages = [];

          List<ImageRoomModel> getDataImageSuperDeluxeRoom =
              await sl<RoomApiService>().getall_roomsWithsuperDelocs_shopper();
          for (var element in getDataImageSuperDeluxeRoom) {
            superDeluxeRoomImages.add(
                RoomShort(id: element.id, image: element.image_room.first.url));
          }

          List<ImageRoomModel> getDataImageDeluxeRoom =
              await sl<RoomApiService>().getall_roomsWithDelocs_shopper();
          for (var element in getDataImageDeluxeRoom) {
            deluxeRoomImages.add(
                RoomShort(id: element.id, image: element.image_room.first.url));
          }

          List<ImageRoomModel> getDataImageVipRoom =
              await sl<RoomApiService>().getMyroomVip_shopper();
          for (var element in getDataImageVipRoom) {
            vipRoomImages.add(
                RoomShort(id: element.id, image: element.image_room.first.url));
          }

          GetWiddModel getWiddModel = await sl<WiddApiService>().get_my_widd();
          HotelInfo hotel = HotelInfo(
              name: 'Muhammad',
              imagePaths: [
                'assets/image/photo.jpg',
                'assets/image/photo.jpg',
                'assets/image/photo.jpg',
                'assets/image/photo.jpg',
                'assets/image/photo.jpg',
              ],
              rooms: [
                RoomType(
                  title: 'VIP Rooms',
                  images: vipRoomImages,
                ),
                RoomType(
                  title: 'Deluxe Rooms',
                  images: deluxeRoomImages,
                ),
                RoomType(
                  title: 'Super Deluxe Rooms',
                  images: superDeluxeRoomImages,
                ),
              ],
              getWiddModel: getWiddModel);

          emit(LoadedProGetHotelState(
            hotelInfo: hotel,
          ));
        } catch (e) {
          emit(ErrorGetHotelState(
            message: e.toString(),
          ));
        }
      } else if (event is RefreshInfoHotelEvent) {
        emit(LoadingGetHotelState());
        try {
          final List<RoomShort> superDeluxeRoomImages = [];
          final List<RoomShort> vipRoomImages = [];
          final List<RoomShort> deluxeRoomImages = [];

          List<ImageRoomModel> getDataImageSuperDeluxeRoom =
              await sl<RoomApiService>().getall_roomsWithsuperDelocs_shopper();
          for (var element in getDataImageSuperDeluxeRoom) {
            superDeluxeRoomImages.add(
                RoomShort(id: element.id, image: element.image_room.first.url));
          }

          List<ImageRoomModel> getDataImageDeluxeRoom =
              await sl<RoomApiService>().getall_roomsWithDelocs_shopper();
          for (var element in getDataImageDeluxeRoom) {
            deluxeRoomImages.add(
                RoomShort(id: element.id, image: element.image_room.first.url));
          }

          List<ImageRoomModel> getDataImageVipRoom =
              await sl<RoomApiService>().getMyroomVip_shopper();
          for (var element in getDataImageVipRoom) {
            vipRoomImages.add(
                RoomShort(id: element.id, image: element.image_room.first.url));
          }

          GetWiddModel getWiddModel = await sl<WiddApiService>().get_my_widd();
          HotelInfo hotel = HotelInfo(
              name: 'Muhammad',
              imagePaths: [
                'assets/image/photo.jpg',
                'assets/image/photo.jpg',
                'assets/image/photo.jpg',
                'assets/image/photo.jpg',
                'assets/image/photo.jpg',
              ],
              rooms: [
                RoomType(
                  title: 'VIP Rooms',
                  images: vipRoomImages,
                ),
                RoomType(
                  title: 'Deluxe Rooms',
                  images: deluxeRoomImages,
                ),
                RoomType(
                  title: 'Super Deluxe Rooms',
                  images: superDeluxeRoomImages,
                ),
              ],
              getWiddModel: getWiddModel);

          emit(LoadedProGetHotelState(
            hotelInfo: hotel,
          ));
        } catch (e) {
          emit(ErrorGetHotelState(
            message: e.toString(),
          ));
        }
      }
    });
  }
}

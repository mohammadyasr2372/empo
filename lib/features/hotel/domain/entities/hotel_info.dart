// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_mobileentifier_names, non_constant_identifier_names, file_names

import 'package:party/features/hotel/domain/entities/room_type.dart';

import '../../data/model/get_widd_model.dart';

class HotelInfo {
  final String name;
  final List<String> imagePaths;
  final List<RoomType> rooms;
  final GetWiddModel getWiddModel;
  HotelInfo(
      {required this.getWiddModel,
      required this.name,
      required this.imagePaths,
      required this.rooms});
}

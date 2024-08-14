// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:party/features/hotel/data/model/get_widd_model.dart';
import 'package:party/features/hotel/domain/entities/room_type.dart';

import 'pageviewhotel.dart';
import 'pageviewhotel_widd.dart';

class TypeSection extends StatelessWidget {
  final RoomType? room;
  final GetWiddModel? getWiddModel;

  const TypeSection({super.key, this.room, this.getWiddModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            room != null ? room!.title : getWiddModel!.NameWiddin,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          room != null
              ? Pageviewhotel(
                  roomType: room!,
                )
              : PageviewhotelWidd(
                  getWiddModel: getWiddModel!,
                ),
          const SizedBox(height: 5),
          const Divider(),
        ],
      ),
    );
  }
}

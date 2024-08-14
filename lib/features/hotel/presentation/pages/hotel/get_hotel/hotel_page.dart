// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:party/injection_container.dart' as di;

import '../../../bloc/get_hotel/get_hotel_bloc.dart';
import 'hotel_images_section.dart';
import 'type_section.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => di.sl<GetHotelBloc>()..add(GetInfoHotelEvent()),
        child: BlocConsumer<GetHotelBloc, GetHotelState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadedProGetHotelState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    HotelImagesSection(
                      imagePaths: state.hotelInfo.imagePaths,
                    ),
                    TypeSection(room: state.hotelInfo.rooms[0]),
                    TypeSection(room: state.hotelInfo.rooms[1]),
                    TypeSection(room: state.hotelInfo.rooms[2]),
                    TypeSection(
                      getWiddModel: state.hotelInfo.getWiddModel,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(state.toString()),
              );
            }
          },
        ),
      ),
    );
  }
}

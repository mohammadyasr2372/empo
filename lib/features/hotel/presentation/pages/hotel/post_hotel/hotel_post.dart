// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, use_super_parameters

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:party/features/hotel/data/data_sources/remote/hotel_api_service.dart';
import 'package:party/features/hotel/data/data_sources/remote/room_api_service.dart';
import 'package:party/features/hotel/data/data_sources/remote/widd_api_service.dart';
import 'package:party/features/hotel/domain/entities/hotel_entity.dart';
import 'package:party/features/hotel/domain/entities/room_entity.dart';
import 'package:party/features/hotel/domain/entities/widd_hotel_post.dart';
import 'package:party/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/strings/constans.dart';
import '../../../../../../injection_container.dart';
import 'image_slider.dart';
import 'room_section_post.dart';

class PostHotel extends StatefulWidget {
  const PostHotel({Key? key}) : super(key: key);

  @override
  _PostHotelState createState() => _PostHotelState();
}

class _PostHotelState extends State<PostHotel> {
  final PageController _pageController = PageController(initialPage: 0);
  final PageController _WiddController = PageController(initialPage: 0);
  final PageController _vipRoomPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  final PageController _superDeluxeRoomPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  final PageController _deluxeRoomPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  final ImagePicker _picker = ImagePicker();
  List<File> _hotelImages = [];
  List<File> _vipRoomImages = [];
  List<Uint8List> imageRoomVip = [];
  List<File> _superDeluxeRoomImages = [];
  List<File> _deluxeRoomImages = [];
  List<File> _WiddHotalImages = [];
  late Timer _timer;
  int _activePage = 0;

  final TextEditingController _NameWiddinController = TextEditingController();
  final TextEditingController _bookpriceController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _personbookController = TextEditingController();
  final TextEditingController _capacityMinController = TextEditingController();

  final TextEditingController _vipRoomPriceController = TextEditingController();
  final TextEditingController _vipRoomnameController = TextEditingController();

  final TextEditingController _superDeluxeRoomPriceController =
      TextEditingController();
  final TextEditingController _superDeluxeRoomnameController =
      TextEditingController();

  final TextEditingController _deluxeRoomPriceController =
      TextEditingController();
  final TextEditingController _deluxeRoomnameController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (_hotelImages.isNotEmpty &&
            _pageController.page == _hotelImages.length - 1) {
          _pageController.animateToPage(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _vipRoomPriceController.dispose();
    _vipRoomnameController.dispose();
    _superDeluxeRoomPriceController.dispose();
    _superDeluxeRoomnameController.dispose();
    _deluxeRoomPriceController.dispose();
    _deluxeRoomnameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage({required List<File> imageList}) async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        imageList
            .addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Images'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageSlider(
              images: _hotelImages,
              pageController: _pageController,
              activePage: _activePage,
              onAddImage: () => _pickImage(imageList: _hotelImages),
            ),
            const SizedBox(height: 10),
            RoomSectionPost(
              title: 'VIP Rooms',
              images: _vipRoomImages,
              pageController: _vipRoomPageController,
              priceController: _vipRoomPriceController,
              nameController: _vipRoomnameController,
              onAddImage: () => _pickImage(imageList: _vipRoomImages),
            ),
            const SizedBox(height: 10),
            RoomSectionPost(
              title: 'Super Deluxe Rooms',
              images: _superDeluxeRoomImages,
              pageController: _superDeluxeRoomPageController,
              priceController: _superDeluxeRoomPriceController,
              nameController: _superDeluxeRoomnameController,
              onAddImage: () => _pickImage(imageList: _superDeluxeRoomImages),
            ),
            const SizedBox(height: 10),
            RoomSectionPost(
              title: 'Deluxe Rooms',
              images: _deluxeRoomImages,
              pageController: _deluxeRoomPageController,
              priceController: _deluxeRoomPriceController,
              nameController: _deluxeRoomnameController,
              onAddImage: () => _pickImage(imageList: _deluxeRoomImages),
            ),
            const SizedBox(height: 10),
            WiddSectionPost(
              title: 'Widd Hotal',
              images: _WiddHotalImages,
              pageController: _WiddController,
              NameWiddinController: _NameWiddinController,
              bookpriceController: _bookpriceController,
              onAddImage: () => _pickImage(imageList: _WiddHotalImages),
              capacityController: _capacityController,
              personbookController: _personbookController,
              capacityMinController: _capacityMinController,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await sl<HotelApiService>().add_hotelInfo(
                      newHotel: Hotel(imagesHotel: _hotelImages));
                  await sl<RoomApiService>().addRoom(
                      newRoom: Room(
                    room_type: 'vip',
                    price_day: _vipRoomPriceController.text,
                    name_room: _vipRoomnameController.text,
                    image_room: _vipRoomImages,
                  ));
                  await sl<RoomApiService>().addRoom(
                      newRoom: Room(
                    room_type: 'Delocs',
                    price_day: _deluxeRoomPriceController.text,
                    name_room: _deluxeRoomnameController.text,
                    image_room: _deluxeRoomImages,
                  ));
                  await sl<RoomApiService>().addRoom(
                      newRoom: Room(
                    room_type: 'superDelocs',
                    price_day: _superDeluxeRoomPriceController.text,
                    name_room: _superDeluxeRoomnameController.text,
                    image_room: _superDeluxeRoomImages,
                  ));
                  await sl<WiddApiService>().addWidd(
                      newWidd: WiddHotelPost(
                          hotelId: _NameWiddinController.text,
                          bookprice: _bookpriceController.text,
                          capacity: _capacityController.text,
                          personbook: _personbookController.text,
                          capacityMin: _capacityMinController.text,
                          imagewids_hotal: _WiddHotalImages));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      const Size(double.infinity, 50), // Full-width button
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

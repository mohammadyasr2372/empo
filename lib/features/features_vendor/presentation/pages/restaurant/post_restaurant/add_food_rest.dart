// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, use_super_parameters, library_private_types_in_public_api
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party/features/features_vendor/presentation/widgets/models/model_restaurant.dart';

import '../../../../../../injection_container.dart';
import '../../../../data/data_source/restaurnat_data_source/resturant_datasource.dart';
import 'custom_text_field.dart';
import 'image_picker_helper.dart';
import 'menu_slider.dart';

class AddFoodRestaurant extends StatefulWidget {
  const AddFoodRestaurant({
    Key? key,
  }) : super(key: key);
  @override
  _AddFoodRestaurantState createState() => _AddFoodRestaurantState();
}

class _AddFoodRestaurantState extends State<AddFoodRestaurant> {
  final PageController _pageController = PageController(initialPage: 0);
  final PageController _hospitalityPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  List<File> _initialImages = [];
  List<MenuImage> _menuImages = [];
  late Timer _timer;
  int _activePage = 0;

  int _price_table = 500;
  int _all_table = 2500;
  double? all_table;
  double? price_table;
  List<File>? restImages;
  final TextEditingController _price_tableController = TextEditingController();
  final TextEditingController _num_bookedController = TextEditingController();
  final TextEditingController _all_tableController = TextEditingController();

  @override
  void dispose() {
    _timer.cancel();
    _price_tableController.dispose();
    _all_tableController.dispose();
    super.dispose();
  }

  Future<void> _pickImage({required bool isInitial}) async {
    List<File> pickedImages = await _imagePickerHelper.pickImages();
    if (pickedImages.isNotEmpty) {
      setState(() {
        if (isInitial) {
          _initialImages.addAll(pickedImages);
        } else {
          _menuImages.addAll(pickedImages
              .map((image) => MenuImage(image: image, price: 0, name: ' ')));
        }
      });
    }
  }

  void _bindShooperInput() {
    setState(() {
      price_table = double.tryParse(_price_tableController.text);
      all_table = double.tryParse(_all_tableController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // ImageSlider(
              //   images: _initialImages,
              //   controller: _pageController,
              //   onAddImage: () => _pickImage(isInitial: true),
              //   activePage: _activePage,
              // ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () => _pickImage(isInitial: true),
                child: const Text('Add Image'),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _price_tableController,
                labelText: 'Price Table',
                onChanged: (value) {
                  setState(() {
                    _price_table = int.tryParse(value) ?? _price_table;
                  });
                },
              ),
              CustomTextField(
                controller: _num_bookedController,
                labelText: 'num booked Person',
                onChanged: (value) {
                  setState(() {
                    _price_table = int.tryParse(value) ?? _price_table;
                  });
                },
              ),
              CustomTextField(
                controller: _all_tableController,
                labelText: 'Num All Table',
                onChanged: (value) {
                  setState(() {
                    _all_table = int.tryParse(value) ?? _all_table;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Menu',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              MenuSlider(
                menuImages: _menuImages,
                controller: _hospitalityPageController,
                onAddImage: () => _pickImage(isInitial: false),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _pickImage(isInitial: false),
                child: const Text('Add Menu Image'),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // await sl<ResturantDatasource>()
                    //     .addResturantdetailsdatasource(
                    //         addRestaurant: AddRestaurant(
                    //             date: '2020-02-01',
                    //             all_table: int.parse(_all_tableController.text),
                    //             number_booked:
                    //                 int.parse(_num_bookedController.text),
                    //             price_table:
                    //                 int.parse(_price_tableController.text),
                    // rest_image: _initialImages));
                    _menuImages.forEach((element) async {
                      await sl<ResturantDatasource>()
                          .addFoodDetailsdatasource(menuImage: element);
                    });
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (_) => MainScreen()));
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
      ),
    );
  }
}

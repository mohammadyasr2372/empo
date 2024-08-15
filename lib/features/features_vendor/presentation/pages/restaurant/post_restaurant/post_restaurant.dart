// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, use_super_parameters, library_private_types_in_public_api
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:party/features/features_vendor/presentation/widgets/models/model_restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:party/core/strings/constans.dart';
import 'package:party/injection_container.dart' as di;

import '../../../../../../injection_container.dart';
import '../../../../data/data_source/restaurnat_data_source/resturant_datasource.dart';
import '../../shopper/MainScreenShopper.dart';

class ImagePickerHelper {
  final ImagePicker _picker = ImagePicker();

  Future<List<File>> pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      return pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    }
    return [];
  }
}

class ImageSlider extends StatefulWidget {
  final List<File> images;
  final PageController controller;
  final VoidCallback onAddImage;
  final int activePage;

  const ImageSlider({
    Key? key,
    required this.images,
    required this.controller,
    required this.onAddImage,
    required this.activePage,
  }) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late int _activePage;

  @override
  void initState() {
    super.initState();
    _activePage = widget.activePage;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3.4,
          child: widget.images.isNotEmpty
              ? PageView.builder(
                  controller: widget.controller,
                  itemCount: widget.images.length,
                  onPageChanged: (value) {
                    setState(() {
                      _activePage = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.file(
                      widget.images[index],
                      fit: BoxFit.cover,
                    );
                  },
                )
              : Container(
                  color: Colors.grey,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo,
                          color: Colors.white, size: 50),
                      onPressed: widget.onAddImage,
                    ),
                  ),
                ),
        ),
        if (widget.images.isNotEmpty)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  widget.images.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: InkWell(
                      onTap: () {
                        widget.controller.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: _activePage == index
                            ? Colors.deepPurple
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class MenuSlider extends StatefulWidget {
  final List<MenuImage> menuImages;
  final PageController controller;
  final VoidCallback onAddImage;

  const MenuSlider({
    Key? key,
    required this.menuImages,
    required this.controller,
    required this.onAddImage,
  }) : super(key: key);

  @override
  _MenuSliderState createState() => _MenuSliderState();
}

class _MenuSliderState extends State<MenuSlider> {
  late int _activePage;

  @override
  void initState() {
    super.initState();
    _activePage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        controller: widget.controller,
        itemCount: widget.menuImages.length + 1,
        onPageChanged: (value) {
          setState(() {
            _activePage = value;
          });
        },
        itemBuilder: (context, index) {
          if (index == widget.menuImages.length) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.add_a_photo,
                        color: Colors.white, size: 50),
                    onPressed: widget.onAddImage,
                  ),
                ),
              ),
            );
          } else {
            return Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: FileImage(widget.menuImages[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 180,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.menuImages[index].name}      ',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${widget.menuImages[index].price} USD',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showPriceDialog(context, index),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> _showPriceDialog(BuildContext context, int index) async {
    TextEditingController _priceController = TextEditingController();
    TextEditingController _nameController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set Price'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price Food'),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name Food'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final double? price = double.tryParse(_priceController.text);
                if (price != null && _nameController.text != null) {
                  setState(() {
                    widget.menuImages[index].price = price;
                    widget.menuImages[index].name = _nameController.text;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Set'),
            ),
          ],
        );
      },
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class PostRestaurant extends StatefulWidget {
  const PostRestaurant({
    Key? key,
  }) : super(key: key);
  @override
  _PostRestaurantState createState() => _PostRestaurantState();
}

class _PostRestaurantState extends State<PostRestaurant> {
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

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (_initialImages.isNotEmpty &&
            _pageController.page == _initialImages.length - 1) {
          _pageController.animateToPage(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        } else {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        }
      },
    );
  }

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
              ImageSlider(
                images: _initialImages,
                controller: _pageController,
                onAddImage: () => _pickImage(isInitial: true),
                activePage: _activePage,
              ),
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
                    await sl<ResturantDatasource>()
                        .addResturantdetailsdatasource(
                            addRestaurant: AddRestaurant(
                                date: '2020-02-01',
                                all_table: int.parse(_all_tableController.text),
                                number_booked:
                                    int.parse(_num_bookedController.text),
                                price_table:
                                    int.parse(_price_tableController.text),
                                rest_image: _initialImages));
                    _menuImages.forEach((element) async {
                      await sl<ResturantDatasource>()
                          .addFoodDetailsdatasource(menuImage: element);
                    });
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => MainScreen()));
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

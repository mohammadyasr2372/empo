// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, use_super_parameters, library_private_types_in_public_api
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:party/features/features_vendor/presentation/widgets/models/model_cande.dart';
import 'package:party/features/features_vendor/presentation/widgets/models/model_restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:party/core/strings/constans.dart';
import 'package:party/injection_container.dart' as di;

import '../../../../../../injection_container.dart';
import '../../../../data/data_source/candiesshop_datasource/candiesShop_datasource.dart';
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

class MenuSweetImage {
  final File sweet_image;
  double sweet_price;
  String sweet_name;
  double sweet_amont;
  MenuSweetImage({
    required this.sweet_image,
    required this.sweet_price,
    required this.sweet_name,
    required this.sweet_amont,
  });
}

class MenuSlider extends StatefulWidget {
  final List<MenuSweetImage> menuSweetImages;
  final PageController controller;
  final VoidCallback onAddImage;

  const MenuSlider({
    Key? key,
    required this.menuSweetImages,
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
        itemCount: widget.menuSweetImages.length + 1,
        onPageChanged: (value) {
          setState(() {
            _activePage = value;
          });
        },
        itemBuilder: (context, index) {
          if (index == widget.menuSweetImages.length) {
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
                      image:
                          FileImage(widget.menuSweetImages[index].sweet_image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 180,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.menuSweetImages[index].sweet_name}      ',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${widget.menuSweetImages[index].sweet_price} USD',
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
    TextEditingController _amontController = TextEditingController();

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
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _amontController,
                decoration: const InputDecoration(labelText: ' Amont Sweet'),
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
                    widget.menuSweetImages[index].sweet_price = price;
                    widget.menuSweetImages[index].sweet_name =
                        _nameController.text;
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

class PostCande extends StatefulWidget {
  const PostCande({
    Key? key,
  }) : super(key: key);
  @override
  _PostCandeState createState() => _PostCandeState();
}

class _PostCandeState extends State<PostCande> {
  final PageController _pageController = PageController(initialPage: 0);
  final PageController _hospitalityPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  List<File> _initialImages = [];
  List<MenuSweetImage> _menuSweetImages = [];
  late Timer _timer;
  int _activePage = 0;

  int _price_table = 500;
  int _all_table = 2500;
  double? all_table;
  double? price_table;
  List<File>? restImages;

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
    super.dispose();
  }

  Future<void> _pickImage({required bool isInitial}) async {
    List<File> pickedImages = await _imagePickerHelper.pickImages();
    if (pickedImages.isNotEmpty) {
      setState(() {
        if (isInitial) {
          _initialImages.addAll(pickedImages);
        } else {
          _menuSweetImages.addAll(pickedImages.map((image) => MenuSweetImage(
                sweet_amont: 0,
                sweet_image: image,
                sweet_price: 0,
                sweet_name: ' ',
              )));
        }
      });
    }
  }

  // void _bindShooperInput() {
  //   setState(() {
  //     price_table = double.tryParse(_price_tableController.text);
  //     all_table = double.tryParse(_all_tableController.text);
  //   });
  // }

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

              const SizedBox(height: 30),
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
                menuSweetImages: _menuSweetImages,
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
                    await sl<CandiesshopDatasource>().addCandedetailsdatasource(
                        addCande: AddCande(
                            data_open: '03:00', cande_image: _initialImages));
                    _menuSweetImages.forEach((element) async {
                      await sl<CandiesshopDatasource>()
                          .addSweetDetailsdatasource(menuImage: element);
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

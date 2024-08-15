// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../injection_container.dart';
import '../../../../../hotel/data/data_sources/remote/hotel_api_service.dart';
import '../../../../data/data_source/wedding_data_source/weddingHallDataSource.dart';
import '../../../widgets/widget_wedding_hall/widget_post/CustomTextField.dart';
import '../../../widgets/widget_wedding_hall/widget_post/HospitalityCarousel.dart';
import '../../posts/posts_page.dart/pageposts.dart';
import '../../shopper/MainScreenShopper.dart';

class PostImageHospit extends StatefulWidget {
  const PostImageHospit({Key? key}) : super(key: key);

  @override
  _PostImageHospitState createState() => _PostImageHospitState();
}

class _PostImageHospitState extends State<PostImageHospit> {
  final PageController _pageController = PageController(initialPage: 0);
  final PageController _hospitalityPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  final ImagePicker _picker = ImagePicker();
  List<File> _initialImages = [];
  List<File> _hospitalityImages = [];
  late Timer _timer;
  int _activePage = 0;

  int bookedPersons = 50;
  int minPersons = 50;
  int maxCapacity = 200;
  int pricePerPerson = 2500;
  int bookingPrice = 500000;

  final TextEditingController _bookingPriceController = TextEditingController();
  final TextEditingController _maxCapacityController = TextEditingController();
  final TextEditingController _pricePerPersonController =
      TextEditingController();
  final TextEditingController _minPersonsController = TextEditingController();

  @override
  void dispose() {
    _timer.cancel();
    _bookingPriceController.dispose();
    _maxCapacityController.dispose();
    _pricePerPersonController.dispose();
    _minPersonsController.dispose();
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

  void _removeImage(int index) {
    setState(() {
      _initialImages.removeAt(index);
      _hospitalityImages.removeAt(index);
    });
  }

  Future<void> _uploadImages() async {
    // if (_initialImages.isEmpty) {
    //   print('No images selected.');
    //   return;
    // }

    int bookingPrice =
        int.tryParse(_bookingPriceController.text) ?? this.bookingPrice;
    int maxCapacity =
        int.tryParse(_maxCapacityController.text) ?? this.maxCapacity;
    int pricePerPerson =
        int.tryParse(_pricePerPersonController.text) ?? this.pricePerPerson;
    int minPersons =
        int.tryParse(_minPersonsController.text) ?? this.minPersons;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        children: [
          // ImageSlider1(
          //   images: _initialImages,
          //   pageController: _pageController,
          //   pickImage: () => _pickImage(imageList: _initialImages),
          //   activePage: _activePage,
          //   removeImage: (int) {
          //     _removeImage;
          //   },
          // ),
          // const SizedBox(height: 5),
          // ElevatedButton(
          //   onPressed: () => _pickImage(imageList: _initialImages),
          //   child: const Text('Add Image'),
          // ),
          // const SizedBox(height: 10),
          // CustomTextField(
          //   controller: _bookingPriceController,
          //   labelText: 'Booking Price',
          //   onChanged: (value) {
          //     setState(() {
          //       bookingPrice = int.tryParse(value) ?? bookingPrice;
          //     });
          //   },
          // ),
          // CustomTextField(
          //   controller: _maxCapacityController,
          //   labelText: 'Max Capacity',
          //   onChanged: (value) {
          //     setState(() {
          //       maxCapacity = int.tryParse(value) ?? maxCapacity;
          //     });
          //   },
          // ),
          // CustomTextField(
          //   controller: _pricePerPersonController,
          //   labelText: 'Price Per Person',
          //   onChanged: (value) {
          //     setState(() {
          //       pricePerPerson = int.tryParse(value) ?? pricePerPerson;
          //     });
          //   },
          // ),
          // CustomTextField(
          //   controller: _minPersonsController,
          //   labelText: 'Min Persons',
          //   onChanged: (value) {
          //     setState(() {
          //       minPersons = int.tryParse(value) ?? minPersons;
          //     });
          //   },
          // ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Hospitality Images',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 10),
          HospitalityCarousel(
            images: _hospitalityImages,
            pageController: _hospitalityPageController,
            pickImage: () => _pickImage(imageList: _hospitalityImages),
          ),
          ElevatedButton(
            onPressed: () => _pickImage(imageList: _hospitalityImages),
            child: const Text('Add Hospitality Image'),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                // await sl<Weddinghalldatasource>().addweddingdetailsdatasource(
                //     bookingPrice,
                //     maxCapacity,
                //     pricePerPerson,
                //     minPersons,
                //     _initialImages);
                await sl<Weddinghalldatasource>()
                    .addimagehospitdatasource(_hospitalityImages);
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
    )));
  }
}

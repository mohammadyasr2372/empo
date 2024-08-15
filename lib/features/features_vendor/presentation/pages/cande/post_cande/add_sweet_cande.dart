// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, use_super_parameters, library_private_types_in_public_api
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../injection_container.dart';
import '../../../../data/data_source/candiesshop_datasource/candiesShop_datasource.dart';
import 'post_cande.dart';

class AddSweetCande extends StatefulWidget {
  const AddSweetCande({
    Key? key,
  }) : super(key: key);
  @override
  _AddSweetCandeState createState() => _AddSweetCandeState();
}

class _AddSweetCandeState extends State<AddSweetCande> {
  final PageController _hospitalityPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  List<File> _initialImages = [];
  List<MenuSweetImage> _menuSweetImages = [];
  late Timer _timer;

  double? all_table;
  double? price_table;
  List<File>? restImages;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                    // await sl<CandiesshopDatasource>().addCandedetailsdatasource(
                    //     addCande: AddCande(
                    //         data_open: '03:00', cande_image: _initialImages));
                    _menuSweetImages.forEach((element) async {
                      await sl<CandiesshopDatasource>()
                          .addSweetDetailsdatasource(menuImage: element);
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

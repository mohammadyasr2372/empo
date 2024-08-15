// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:party/features/features_vendor/presentation/pages/restaurant/post_restaurant/post_restaurant.dart';
import 'package:party/features/features_vendor/presentation/widgets/models/model_restaurant.dart';

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

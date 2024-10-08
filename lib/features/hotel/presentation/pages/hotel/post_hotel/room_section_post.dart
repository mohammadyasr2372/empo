// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, use_super_parameters, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:party/features/hotel/presentation/pages/hotel/post_hotel/room_carousel_card_post.dart';

class RoomSectionPost extends StatelessWidget {
  final String title;
  final List<File> images;
  final PageController pageController;
  final TextEditingController priceController;
  final TextEditingController nameController;
  final VoidCallback onAddImage;

  const RoomSectionPost({
    Key? key,
    required this.title,
    required this.images,
    required this.pageController,
    required this.priceController,
    required this.nameController,
    required this.onAddImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        RoomCarouselCardPost(
          images: images,
          pageController: pageController,
          onAddImage: onAddImage,
        ),
        _buildTextField(
          controller: priceController,
          labelText: '$title Price',
        ),
        _buildTextField(
          controller: nameController,
          labelText: '$title name',
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class WiddSectionPost extends StatelessWidget {
  final String title;
  final List<File> images;
  final PageController pageController;
  final TextEditingController bookpriceController;
  final TextEditingController capacityController;
  final TextEditingController personbookController;
  final TextEditingController capacityMinController;
  final TextEditingController NameWiddinController;
  final VoidCallback onAddImage;

  const WiddSectionPost({
    Key? key,
    required this.title,
    required this.images,
    required this.pageController,
    required this.bookpriceController,
    required this.NameWiddinController,
    required this.onAddImage,
    required this.capacityController,
    required this.personbookController,
    required this.capacityMinController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        RoomCarouselCardPost(
          images: images,
          pageController: pageController,
          onAddImage: onAddImage,
        ),
        _buildTextField(
          controller: NameWiddinController,
          labelText: '$title name',
        ),
        _buildTextField(
          controller: personbookController,
          labelText: '$title personbook',
        ),
        _buildTextField(
          controller: capacityController,
          labelText: '$title capacity',
        ),
        _buildTextField(
          controller: capacityMinController,
          labelText: '$title Min capacity',
        ),
        _buildTextField(
          controller: bookpriceController,
          labelText: '$title bookprice',
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

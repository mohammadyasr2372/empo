import 'package:flutter/material.dart';
import 'dart:math';

import '../../../../widgets/widget_wedding_hall/widget_get/pageview_animate/room_carousel_view.dart';

class MyApp221 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sweet Shop Booking',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SweetBookingScreen(),
    );
  }
}

class SweetBookingScreen extends StatefulWidget {
  @override
  _SweetBookingScreenState createState() => _SweetBookingScreenState();
}

class _SweetBookingScreenState extends State<SweetBookingScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String _selectedImageId = '';
  int _quantity = 1;

  // Example images with IDs
  final List<String> _imagePaths = [
    'assets/sweet1.jpg', // Replace with actual paths to your image assets
    'assets/sweet2.jpg',
    'assets/sweet3.jpg',
  ];

  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sweet Booking Details',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Quantity Input
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quantity:',
                    style: TextStyle(fontSize: 16, color: Colors.orange)),
                TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter quantity',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _quantity = int.tryParse(value) ?? 1;
                    });
                  },
                ),
                SizedBox(height: 10),
                Text('Entered Quantity: $_quantity',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          ),
          SizedBox(height: 20),
          // PageView for images
          SizedBox(
            height: 250,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _imagePaths.length,
              itemBuilder: (context, index) {
                return HospitalityCarouselView(
                  imagePath: _imagePaths[index],
                  index: index,
                  controller: _pageController,
                );
              },
            ),
          ),
          SizedBox(height: 20),
          // Description Input
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Describe the Sweet',
                hintText: 'Enter a description of the sweet...',
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Logic for handling submission
                final description = _descriptionController.text;
                final quantity = _quantity;
                final selectedImageId = _selectedImageId;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Description: $description\nQuantity: $quantity\nImage ID: $selectedImageId',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: Text('Submit Description',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

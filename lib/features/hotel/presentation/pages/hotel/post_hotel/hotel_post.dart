// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class PostHotel extends StatefulWidget {
//   const PostHotel({Key? key}) : super(key: key);

//   @override
//   _PostHotelState createState() => _PostHotelState();
// }

// class _PostHotelState extends State<PostHotel> {
//   final PageController _pageController = PageController(initialPage: 0);
//   final PageController _vipRoomPageController =
//       PageController(initialPage: 0, viewportFraction: 0.8);
//   final PageController _superDeluxeRoomPageController =
//       PageController(initialPage: 0, viewportFraction: 0.8);
//   final PageController _deluxeRoomPageController =
//       PageController(initialPage: 0, viewportFraction: 0.8);
//   final ImagePicker _picker = ImagePicker();
//   List<File> _hotelImages = [];
//   List<File> _vipRoomImages = [];
//   List<File> _superDeluxeRoomImages = [];
//   List<File> _deluxeRoomImages = [];
//   late Timer _timer;
//   int _activePage = 0;

//   final TextEditingController _vipRoomPriceController = TextEditingController();
//   final TextEditingController _vipRoomCountController = TextEditingController();
//   final TextEditingController _superDeluxeRoomPriceController =
//       TextEditingController();
//   final TextEditingController _superDeluxeRoomCountController =
//       TextEditingController();
//   final TextEditingController _deluxeRoomPriceController =
//       TextEditingController();
//   final TextEditingController _deluxeRoomCountController =
//       TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(
//       const Duration(seconds: 3),
//       (timer) {
//         if (_hotelImages.isNotEmpty &&
//             _pageController.page == _hotelImages.length - 1) {
//           _pageController.animateToPage(0,
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeIn);
//         } else {
//           _pageController.nextPage(
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeIn);
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _vipRoomPriceController.dispose();
//     _vipRoomCountController.dispose();
//     _superDeluxeRoomPriceController.dispose();
//     _superDeluxeRoomCountController.dispose();
//     _deluxeRoomPriceController.dispose();
//     _deluxeRoomCountController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage({required List<File> imageList}) async {
//     final List<XFile>? pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() {
//         imageList
//             .addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
//       });
//     }
//   }

//   Widget _buildImageSlider(List<File> images, PageController controller) {
//     return Stack(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height / 3.4,
//           child: images.isNotEmpty
//               ? PageView.builder(
//                   controller: controller,
//                   itemCount: images.length,
//                   onPageChanged: (value) {
//                     setState(() {
//                       _activePage = value;
//                     });
//                   },
//                   itemBuilder: (context, index) {
//                     return Image.file(
//                       images[index],
//                       fit: BoxFit.cover,
//                     );
//                   },
//                 )
//               : Container(
//                   color: Colors.grey,
//                   child: Center(
//                     child: IconButton(
//                       icon: const Icon(Icons.add_a_photo,
//                           color: Colors.white, size: 50),
//                       onPressed: () => _pickImage(imageList: images),
//                     ),
//                   ),
//                 ),
//         ),
//         if (images.isNotEmpty)
//           Positioned(
//             bottom: 10,
//             left: 0,
//             right: 0,
//             child: Container(
//               color: Colors.transparent,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List<Widget>.generate(
//                   images.length,
//                   (index) => Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                     child: InkWell(
//                       onTap: () {
//                         controller.animateToPage(index,
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeIn);
//                       },
//                       child: CircleAvatar(
//                         radius: 4,
//                         backgroundColor: _activePage == index
//                             ? Colors.deepPurple
//                             : Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildRoomCarouselCard(List<File> images, PageController controller) {
//     return SizedBox(
//       height: 250,
//       child: images.isNotEmpty
//           ? PageView.builder(
//               controller: controller,
//               itemCount: images.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     image: DecorationImage(
//                       image: FileImage(images[index]),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               },
//             )
//           : Container(
//               margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.grey,
//               ),
//               height: 250,
//               child: Center(
//                 child: IconButton(
//                   icon: const Icon(Icons.add_a_photo,
//                       color: Colors.white, size: 50),
//                   onPressed: () => _pickImage(imageList: images),
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget _buildTextField(
//       {required TextEditingController controller,
//       required String labelText,
//       required ValueChanged<String> onChanged}) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         controller: controller,
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//           labelText: labelText,
//           border: const OutlineInputBorder(),
//         ),
//         onChanged: onChanged,
//       ),
//     );
//   }

// ignore_for_file: prefer_final_fields, use_super_parameters, library_private_types_in_public_api

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hotel Images'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildImageSlider(_hotelImages, _pageController),
//             const SizedBox(height: 5),
//             ElevatedButton(
//               onPressed: () => _pickImage(imageList: _hotelImages),
//               child: const Text('Add Hotel Image'),
//             ),
//             const SizedBox(height: 10),
//             const Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'VIP Rooms',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             _buildRoomCarouselCard(_vipRoomImages, _vipRoomPageController),
//             ElevatedButton(
//               onPressed: () => _pickImage(imageList: _vipRoomImages),
//               child: const Text('Add VIP Room Image'),
//             ),
//             _buildTextField(
//               controller: _vipRoomPriceController,
//               labelText: 'VIP Room Price',
//               onChanged: (value) {
//                 // Handle price change
//               },
//             ),
//             _buildTextField(
//               controller: _vipRoomCountController,
//               labelText: 'VIP Room Count',
//               onChanged: (value) {
//                 // Handle room count change
//               },
//             ),
//             const SizedBox(height: 10),
//             const Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'Super Deluxe Rooms',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             _buildRoomCarouselCard(
//                 _superDeluxeRoomImages, _superDeluxeRoomPageController),
//             ElevatedButton(
//               onPressed: () => _pickImage(imageList: _superDeluxeRoomImages),
//               child: const Text('Add Super Deluxe Room Image'),
//             ),
//             _buildTextField(
//               controller: _superDeluxeRoomPriceController,
//               labelText: 'Super Deluxe Room Price',
//               onChanged: (value) {
//                 // Handle price change
//               },
//             ),
//             _buildTextField(
//               controller: _superDeluxeRoomCountController,
//               labelText: 'Super Deluxe Room Count',
//               onChanged: (value) {
//                 // Handle room count change
//               },
//             ),
//             const SizedBox(height: 10),
//             const Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'Deluxe Rooms',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             _buildRoomCarouselCard(
//                 _deluxeRoomImages, _deluxeRoomPageController),
//             ElevatedButton(
//               onPressed: () => _pickImage(imageList: _deluxeRoomImages),
//               child: const Text('Add Deluxe Room Image'),
//             ),
//             _buildTextField(
//               controller: _deluxeRoomPriceController,
//               labelText: 'Deluxe Room Price',
//               onChanged: (value) {
//                 // Handle price change
//               },
//             ),
//             _buildTextField(
//               controller: _deluxeRoomCountController,
//               labelText: 'Deluxe Room Count',
//               onChanged: (value) {
//                 // Handle room count change
//               },
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle save action
//                 },
//                 child: const Text('Save'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize:
//                       const Size(double.infinity, 50), // Full-width button
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostHotel extends StatefulWidget {
  const PostHotel({Key? key}) : super(key: key);

  @override
  _PostHotelState createState() => _PostHotelState();
}

class _PostHotelState extends State<PostHotel> {
  final PageController _pageController = PageController(initialPage: 0);
  final PageController _vipRoomPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  final PageController _superDeluxeRoomPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  final PageController _deluxeRoomPageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  final ImagePicker _picker = ImagePicker();
  List<File> _hotelImages = [];
  List<File> _vipRoomImages = [];
  List<File> _superDeluxeRoomImages = [];
  List<File> _deluxeRoomImages = [];
  late Timer _timer;
  int _activePage = 0;

  final TextEditingController _vipRoomPriceController = TextEditingController();
  final TextEditingController _vipRoomCountController = TextEditingController();
  final TextEditingController _superDeluxeRoomPriceController =
      TextEditingController();
  final TextEditingController _superDeluxeRoomCountController =
      TextEditingController();
  final TextEditingController _deluxeRoomPriceController =
      TextEditingController();
  final TextEditingController _deluxeRoomCountController =
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
    _vipRoomPriceController.dispose();
    _vipRoomCountController.dispose();
    _superDeluxeRoomPriceController.dispose();
    _superDeluxeRoomCountController.dispose();
    _deluxeRoomPriceController.dispose();
    _deluxeRoomCountController.dispose();
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
              countController: _vipRoomCountController,
              onAddImage: () => _pickImage(imageList: _vipRoomImages),
            ),
            const SizedBox(height: 10),
            RoomSectionPost(
              title: 'Super Deluxe Rooms',
              images: _superDeluxeRoomImages,
              pageController: _superDeluxeRoomPageController,
              priceController: _superDeluxeRoomPriceController,
              countController: _superDeluxeRoomCountController,
              onAddImage: () => _pickImage(imageList: _superDeluxeRoomImages),
            ),
            const SizedBox(height: 10),
            RoomSectionPost(
              title: 'Deluxe Rooms',
              images: _deluxeRoomImages,
              pageController: _deluxeRoomPageController,
              priceController: _deluxeRoomPriceController,
              countController: _deluxeRoomCountController,
              onAddImage: () => _pickImage(imageList: _deluxeRoomImages),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle save action
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

class ImageSlider extends StatelessWidget {
  final List<File> images;
  final PageController pageController;
  final int activePage;
  final VoidCallback onAddImage;

  const ImageSlider({
    Key? key,
    required this.images,
    required this.pageController,
    required this.activePage,
    required this.onAddImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3.4,
              child: images.isNotEmpty
                  ? PageView.builder(
                      controller: pageController,
                      itemCount: images.length,
                      onPageChanged: (value) {
                        // Add functionality to update active page if needed
                      },
                      itemBuilder: (context, index) {
                        return Image.file(
                          images[index],
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
                          onPressed: onAddImage,
                        ),
                      ),
                    ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    images.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: InkWell(
                        onTap: () {
                          pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: activePage == index
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
        ),
        ElevatedButton(
          onPressed: onAddImage,
          child: const Text('Add Hotel Image'),
        ),
      ],
    );
  }
}

class RoomSectionPost extends StatelessWidget {
  final String title;
  final List<File> images;
  final PageController pageController;
  final TextEditingController priceController;
  final TextEditingController countController;
  final VoidCallback onAddImage;

  const RoomSectionPost({
    Key? key,
    required this.title,
    required this.images,
    required this.pageController,
    required this.priceController,
    required this.countController,
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
          controller: countController,
          labelText: '$title Count',
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

class RoomCarouselCardPost extends StatelessWidget {
  final List<File> images;
  final PageController pageController;
  final VoidCallback onAddImage;

  const RoomCarouselCardPost({
    Key? key,
    required this.images,
    required this.pageController,
    required this.onAddImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: images.isNotEmpty
              ? PageView.builder(
                  controller: pageController,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: FileImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                  height: 250,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo,
                          color: Colors.white, size: 50),
                      onPressed: onAddImage,
                    ),
                  ),
                ),
        ),
        ElevatedButton(
          onPressed: onAddImage,
          child: const Text('Add Room Image'),
        ),
      ],
    );
  }
}

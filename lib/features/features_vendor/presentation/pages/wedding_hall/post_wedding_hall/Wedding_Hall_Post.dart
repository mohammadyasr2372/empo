// import 'dart:async';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../widgets/widget_wedding_hall/widget_post/CustomTextField.dart';
// import '../../../widgets/widget_wedding_hall/widget_post/HospitalityCarousel.dart';
// import '../../../widgets/widget_wedding_hall/widget_post/ImageSlider.dart';

// class WeddingHallPost extends StatefulWidget {
//   const WeddingHallPost({Key? key}) : super(key: key);

//   @override
//   _WeddingHallPostState createState() => _WeddingHallPostState();
// }

// class _WeddingHallPostState extends State<WeddingHallPost> {
//   final PageController _pageController = PageController(initialPage: 0);
//   final PageController _hospitalityPageController =
//       PageController(initialPage: 0, viewportFraction: 0.8);
//   final ImagePicker _picker = ImagePicker();
//   List<File> _initialImages = [];
//   List<File> _hospitalityImages = [];
//   late Timer _timer;
//   int _activePage = 0;

//   int bookedPersons = 50;
//   int minPersons = 50;
//   int maxCapacity = 200;
//   int pricePerPerson = 2500;
//   int bookingPrice = 500000;

//   final TextEditingController _bookingPriceController = TextEditingController();
//   final TextEditingController _maxCapacityController = TextEditingController();
//   final TextEditingController _pricePerPersonController =
//       TextEditingController();
//   final TextEditingController _minPersonsController = TextEditingController();

//   @override
//   void dispose() {
//     _timer.cancel();
//     _bookingPriceController.dispose();
//     _maxCapacityController.dispose();
//     _pricePerPersonController.dispose();
//     _minPersonsController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage({required bool isInitial}) async {
//     final List<XFile>? pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() {
//         if (isInitial) {
//           _initialImages
//               .addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
//         } else {
//           _hospitalityImages
//               .addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
//         }
//       });
//     }
//   }

//   final Dio _dio = Dio();

//   Future<void> _uploadImages({required bool isInitial}) async {
//     List<File> imagesToUpload = isInitial ? _initialImages : _hospitalityImages;

//     if (imagesToUpload.isEmpty) {
//       print('No images selected.');
//       return;
//     }

//     FormData formData = FormData();
//     for (var image in imagesToUpload) {
//       formData.files.add(MapEntry(
//         "images",
//         await MultipartFile.fromFile(image.path,
//             filename: image.path.split('/').last),
//       ));
//     }

//     try {
//       Response response = await _dio.post(
//         'http://10.0.2.2:8001/images/add/',
//         data: formData,
//       );

//       if (response.statusCode == 201) {
//         print('Images uploaded successfully');
//         print('Response data: ${response.data}');
//       } else {
//         print('Image upload failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Image upload failed: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               ImageSlider(
//                 images: _initialImages,
//                 pageController: _pageController,
//                 pickImage: () => _pickImage(isInitial: true),
//                 activePage: _activePage,
//               ),
//               const SizedBox(height: 5),
//               ElevatedButton(
//                 onPressed: () => _pickImage(isInitial: true),
//                 child: const Text('Add Image'),
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: _bookingPriceController,
//                 labelText: 'Booking Price',
//                 onChanged: (value) {
//                   setState(() {
//                     bookingPrice = int.tryParse(value) ?? bookingPrice;
//                   });
//                 },
//               ),
//               CustomTextField(
//                 controller: _maxCapacityController,
//                 labelText: 'Max Capacity',
//                 onChanged: (value) {
//                   setState(() {
//                     maxCapacity = int.tryParse(value) ?? maxCapacity;
//                   });
//                 },
//               ),
//               CustomTextField(
//                 controller: _pricePerPersonController,
//                 labelText: 'Price Per Person',
//                 onChanged: (value) {
//                   setState(() {
//                     pricePerPerson = int.tryParse(value) ?? pricePerPerson;
//                   });
//                 },
//               ),
//               CustomTextField(
//                 controller: _minPersonsController,
//                 labelText: 'Min Persons',
//                 onChanged: (value) {
//                   setState(() {
//                     minPersons = int.tryParse(value) ?? minPersons;
//                   });
//                 },
//               ),
//               const SizedBox(height: 10),
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     'Hospitality Images',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               HospitalityCarousel(
//                 images: _hospitalityImages,
//                 pageController: _hospitalityPageController,
//                 pickImage: () => _pickImage(isInitial: false),
//               ),
//               ElevatedButton(
//                 onPressed: () => _pickImage(isInitial: false),
//                 child: const Text('Add Hospitality Image'),
//               ),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _uploadImages(isInitial: true);
//                     },
//                     child: const Text('Proceed to Booking',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.white)),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       backgroundColor: Colors.deepPurple,
//                       textStyle: const TextStyle(fontSize: 18),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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

class WeddingHallPost extends StatefulWidget {
  const WeddingHallPost({Key? key}) : super(key: key);

  @override
  _WeddingHallPostState createState() => _WeddingHallPostState();
}

class _WeddingHallPostState extends State<WeddingHallPost> {
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
          ImageSlider1(
            images: _initialImages,
            pageController: _pageController,
            pickImage: () => _pickImage(imageList: _initialImages),
            activePage: _activePage,
            removeImage: (int) {
              _removeImage;
            },
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            onPressed: () => _pickImage(imageList: _initialImages),
            child: const Text('Add Image'),
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: _bookingPriceController,
            labelText: 'Booking Price',
            onChanged: (value) {
              setState(() {
                bookingPrice = int.tryParse(value) ?? bookingPrice;
              });
            },
          ),
          CustomTextField(
            controller: _maxCapacityController,
            labelText: 'Max Capacity',
            onChanged: (value) {
              setState(() {
                maxCapacity = int.tryParse(value) ?? maxCapacity;
              });
            },
          ),
          CustomTextField(
            controller: _pricePerPersonController,
            labelText: 'Price Per Person',
            onChanged: (value) {
              setState(() {
                pricePerPerson = int.tryParse(value) ?? pricePerPerson;
              });
            },
          ),
          CustomTextField(
            controller: _minPersonsController,
            labelText: 'Min Persons',
            onChanged: (value) {
              setState(() {
                minPersons = int.tryParse(value) ?? minPersons;
              });
            },
          ),
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
                await sl<Weddinghalldatasource>().addweddingdetailsdatasource(
                    bookingPrice,
                    maxCapacity,
                    pricePerPerson,
                    minPersons,
                    _initialImages);
                await sl<Weddinghalldatasource>()
                    .addimagehospitdatasource(_hospitalityImages);

                // await sl<HotelApiService>().add_hotelInfo(
                //     newHotel: Hotel(imagesHotel: _hotelImages));
                // await sl<RoomApiService>().addRoom(
                //     newRoom: Room(
                //   room_type: 'vip',
                //   price_day: _vipRoomPriceController.text,
                //   name_room: _vipRoomnameController.text,
                //   image_room: _vipRoomImages,
                // ));
                // await sl<RoomApiService>().addRoom(
                //     newRoom: Room(
                //   room_type: 'Delocs',
                //   price_day: _deluxeRoomPriceController.text,
                //   name_room: _deluxeRoomnameController.text,
                //   image_room: _deluxeRoomImages,
                // ));
                // await sl<RoomApiService>().addRoom(
                //     newRoom: Room(
                //   room_type: 'superDelocs',
                //   price_day: _superDeluxeRoomPriceController.text,
                //   name_room: _superDeluxeRoomnameController.text,
                //   image_room: _superDeluxeRoomImages,
                // ));
                // await sl<WiddApiService>().addWidd(
                //     newWidd: WiddHotelPost(
                //         hotelId: _NameWiddinController.text,
                //         bookprice: _bookpriceController.text,
                //         capacity: _capacityController.text,
                //         personbook: _personbookController.text,
                //         capacityMin: _capacityMinController.text,
                //         imagewids_hotal: _WiddHotalImages));
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






// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:dio/dio.dart';

// class WeddingHallPost extends StatefulWidget {
//   const WeddingHallPost({Key? key}) : super(key: key);

//   @override
//   _WeddingHallPostState createState() => _WeddingHallPostState();
// }

// class _WeddingHallPostState extends State<WeddingHallPost> {

//   final PageController _pageController = PageController(initialPage: 0);
//   final PageController _hospitalityPageController =
//       PageController(initialPage: 0, viewportFraction: 0.8);
//   final ImagePicker _picker = ImagePicker();
//   List<File> _initialImages = [];
//   List<File> _hospitalityImages = [];
//   late Timer _timer;
//   int _activePage = 0;

//   int bookedPersons = 50;
//   int minPersons = 50;
//   int maxCapacity = 200;
//   int pricePerPerson = 2500;
//   int bookingPrice = 500000;

//   final TextEditingController _bookingPriceController = TextEditingController();
//   final TextEditingController _maxCapacityController = TextEditingController();
//   final TextEditingController _pricePerPersonController =
//       TextEditingController();
//   final TextEditingController _minPersonsController = TextEditingController();

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _startTimer();
//   // }

//   void _startTimer() {
//     _timer = Timer.periodic(
//       const Duration(seconds: 3),
//       (timer) {
//         if (_initialImages.isNotEmpty &&
//             _pageController.page == _initialImages.length - 1) {
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
//     _bookingPriceController.dispose();
//     _maxCapacityController.dispose();
//     _pricePerPersonController.dispose();
//     _minPersonsController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage({required bool isInitial}) async {
//     final List<XFile>? pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() {
//         if (isInitial) {
//           _initialImages
//               .addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
//         } else {
//           _hospitalityImages
//               .addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
//         }
//       });
//      // await _uploadImages(isInitial: isInitial);
//     }
//   }

//   final Dio _dio = Dio();

//   Future<void> _uploadImages({required bool isInitial}) async {
//     List<File> imagesToUpload = isInitial ? _initialImages : _hospitalityImages;

//     if (imagesToUpload.isEmpty) {
//       print('No images selected.');
//       return;
//     }

//     FormData formData = FormData();
//     for (var image in imagesToUpload) {
//       formData.files.add(MapEntry(
//         "images",
//         await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
//       ));
//     }

//     try {
//       Response response = await _dio.post(
//         'http://10.0.2.2:8001/images/add/',
//         data: formData,
//       );

//       if (response.statusCode == 201) {
//         print('Images uploaded successfully');
//         print('Response data: ${response.data}');
//       } else {
//         print('Image upload failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Image upload failed: $e');
//     }
//   }

//   void _navigateToBookingPage(BuildContext context) {
//     // Navigate to booking page (implement this function according to your navigation logic)
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
//                       onPressed: () => _pickImage(isInitial: true),
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

//   Widget _buildHospitalityCarouselCard(File image) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         image: DecorationImage(
//           image: FileImage(image),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               _buildImageSlider(_initialImages, _pageController),
//               const SizedBox(height: 5),
//               ElevatedButton(
//                 onPressed: () => _pickImage(isInitial: true),
//                 child: const Text('Add Image'),
//               ),
//               const SizedBox(height: 10),
//               _buildTextField(
//                 controller: _bookingPriceController,
//                 labelText: 'Booking Price',
//                 onChanged: (value) {
//                   setState(() {
//                     bookingPrice = int.tryParse(value) ?? bookingPrice;
//                   });
//                 },
//               ),
//               _buildTextField(
//                 controller: _maxCapacityController,
//                 labelText: 'Max Capacity',
//                 onChanged: (value) {
//                   setState(() {
//                     maxCapacity = int.tryParse(value) ?? maxCapacity;
//                   });
//                 },
//               ),
//               _buildTextField(
//                 controller: _pricePerPersonController,
//                 labelText: 'Price Per Person',
//                 onChanged: (value) {
//                   setState(() {
//                     pricePerPerson = int.tryParse(value) ?? pricePerPerson;
//                   });
//                 },
//               ),
//               _buildTextField(
//                 controller: _minPersonsController,
//                 labelText: 'Min Persons',
//                 onChanged: (value) {
//                   setState(() {
//                     minPersons = int.tryParse(value) ?? minPersons;
//                   });
//                 },
//               ),
//               const SizedBox(height: 10),
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     'Hospitality Images',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                 height: 250,
//                 child: PageView.builder(
//                   controller: _hospitalityPageController,
//                   itemCount: _hospitalityImages.length + 1,
//                   itemBuilder: (context, index) {
//                     if (index == _hospitalityImages.length) {
//                       return Center(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Colors.grey,
//                           ),
//                           child: Center(
//                             child: IconButton(
//                               icon: const Icon(Icons.add_a_photo,
//                                   color: Colors.white, size: 50),
//                               onPressed: () => _pickImage(isInitial: false),
//                             ),
//                           ),
//                         ),
//                       );
//                     } else {
//                       return _buildHospitalityCarouselCard(
//                           _hospitalityImages[index]);
//                     }
//                   },
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () => _pickImage(isInitial: false),
//                 child: const Text('Add Hospitality Image'),
//               ),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _uploadImages(isInitial: true);
//                     },
//                     child: const Text('Proceed to Booking',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.white)),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       backgroundColor: Colors.deepPurple,
//                       textStyle: const TextStyle(fontSize: 18),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Widget hospitalityCarouselCard(File image) {
// //   return Column(
// //     children: <Widget>[
// //       Expanded(
// //         child: Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: Container(
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(15),
// //               image: DecorationImage(
// //                 image: FileImage(image),
// //                 fit: BoxFit.cover,
// //               ),
// //               boxShadow: const [
// //                 BoxShadow(
// //                   offset: Offset(0, 4),
// //                   blurRadius: 4,
// //                   color: Colors.black26,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     ],
// //   );
// // }

// // class ImagePlaceholder extends StatelessWidget {
// //   final String? imagePath;

// //   const ImagePlaceholder({Key? key, this.imagePath}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Image.asset(
// //       imagePath!,
// //       fit: BoxFit.cover,
// //     );
// //   }
// // }








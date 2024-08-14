// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters, library_private_types_in_public_api
// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:dio/dio.dart';

// class PostRestaurant extends StatefulWidget {
//   const PostRestaurant({Key? key}) : super(key: key);

//   @override
//   _PostRestaurantState createState() => _PostRestaurantState();
// }

// class _PostRestaurantState extends State<PostRestaurant> {
//   final PageController _pageController = PageController(initialPage: 0);
//   final PageController _hospitalityPageController =
//       PageController(initialPage: 0, viewportFraction: 0.8);
//   final ImagePicker _picker = ImagePicker();
//   List<File> _initialImages = [];
//   List<File> _MenuImages = [];
//   late Timer _timer;
//   int _activePage = 0;

//   int price_table = 500;
//   int Average_Price = 2500;

//   final TextEditingController _price_tableController = TextEditingController();
//   final TextEditingController _all_tableController = TextEditingController();
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
//     _price_tableController.dispose();
//     _all_tableController.dispose();
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
//           _MenuImages.addAll(
//               pickedFiles.map((pickedFile) => File(pickedFile.path)));
//         }
//       });
//       // await _uploadImages(isInitial: isInitial);
//     }
//   }

//   final Dio _dio = Dio();

//   Future<void> _uploadImages({required bool isInitial}) async {
//     List<File> imagesToUpload = isInitial ? _initialImages : _MenuImages;

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
//         // appBar: AppBar(
//         //   title: const Text('Slider Widget'),
//         // ),
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
//                 controller: _price_tableController,
//                 labelText: 'price_table',
//                 onChanged: (value) {
//                   setState(() {
//                     price_table = int.tryParse(value) ?? price_table;
//                   });
//                 },
//               ),
//               _buildTextField(
//                 controller: _all_tableController,
//                 labelText: 'Average_Price',
//                 onChanged: (value) {
//                   setState(() {
//                     Average_Price = int.tryParse(value) ?? Average_Price;
//                   });
//                 },
//               ),
//               const SizedBox(height: 10),
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     'Menu',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                 height: 250,
//                 child: PageView.builder(
//                   controller: _hospitalityPageController,
//                   itemCount: _MenuImages.length + 1,
//                   itemBuilder: (context, index) {
//                     if (index == _MenuImages.length) {
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
//                       return _buildHospitalityCarouselCard(_MenuImages[index]);
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

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:party/core/strings/constans.dart';
import 'package:party/injection_container.dart' as di;

class ImageUploader {
  final Dio _dio;

  ImageUploader(this._dio);

  Future<void> uploadImages(List<File> images) async {
    if (images.isEmpty) {
      print('No images selected.');
      return;
    }

    FormData formData = FormData();
    for (var image in images) {
      formData.files.add(MapEntry(
        "images",
        await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
      ));
    }

    try {
      Response response = await _dio.post(
        'http://10.0.2.2:8001/images/add/',
        data: formData,
      );

      if (response.statusCode == 201) {
        print('Images uploaded successfully');
        print('Response data: ${response.data}');
      } else {
        print('Image upload failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Image upload failed: $e');
    }
  }
}

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

class MenuImage {
  final File image;
  double price;
  String name;
  MenuImage({
    required this.image,
    required this.price,
    required this.name,
  });
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
            children: [
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price Food'),
              ),
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.number,
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
  PostRestaurant({
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
  final ImageUploader _imageUploader = ImageUploader(Dio());

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
  final TextEditingController _all_tableController = TextEditingController();
  final TextEditingController _pricePerPersonController =
      TextEditingController();
  final TextEditingController _minPersonsController = TextEditingController();

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
    _price_tableController.dispose();
    _all_tableController.dispose();
    _pricePerPersonController.dispose();
    _minPersonsController.dispose();
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
              .map((image) => MenuImage(image: image, price: 0, name: 'aw')));
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

  // Future<void> _postRestaurantDetails(double? average_Food,
  //     double? number_Chair, List<File> rest_Images) async {
  //   int? price_table = int.tryParse(_price_tableController.text);
  //   int? all_table = int.tryParse(_all_tableController.text);

  //   if (price_table == null || all_table == null) {
  //     // Show an error message if the input is invalid
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please enter valid numbers')),
  //     );
  //     return;
  //   }
  //   Dio dio = Dio();
  //   List<String> imagePaths = rest_Images.map((image) => image.path).toList();

  //   Restaurant restaurant = Restaurant(
  //     all_table: price_table.toInt() ?? 0,
  //     price_table: all_table.toInt() ?? 0,
  //     images:
  //         imagePaths.map((path) => RestaurantImage(restImage: path)).toList(),
  //   );

  //   try {
  //     final response = await dio.post(
  //       'http://10.0.2.2:3000/api/shopper/add_restorantInfo',
  //       data: restaurant.toJson(),
  //       options: Options(
  //         headers: {
  //           'token': di.sl.get<SharedPreferences>().getString(CACHED_Token),
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       // Handle successful response
  //       print('Restaurant data posted successfully.');
  //     } else {
  //       // Handle unexpected response status
  //       print('An error occurred while posting restaurant data.');
  //     }
  //   } catch (e) {
  //     // Handle server connection error
  //     print('An error occurred while connecting to the server: $e');
  //   }
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
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _imageUploader.uploadImages(_initialImages);
                      // _postRestaurantDetails(
                      //   all_table!,
                      //   price_table,
                      //   _initialImages,
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.deepPurple,
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Proceed to Booking',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Restaurant {
  final int all_table;
  final int price_table;
  final List<RestaurantImage> images;

  Restaurant({
    required this.all_table,
    required this.price_table,
    required this.images,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    var imagesJson = json['images'] as List<dynamic>;
    List<RestaurantImage> imagesList =
        imagesJson.map((i) => RestaurantImage.fromJson(i)).toList();

    return Restaurant(
      all_table: json['average_food'],
      price_table: json['number_chair'],
      images: imagesList,
    );
  }

  Map<String, dynamic> toJson() => {
        'average_food': all_table,
        'number_chair': price_table,
        'images': images.map((e) => e.toJson()).toList(),
      };
}

class RestaurantImage {
  final String restImage;

  RestaurantImage({required this.restImage});

  factory RestaurantImage.fromJson(Map<String, dynamic> json) {
    return RestaurantImage(
      restImage: json['rest_image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'rest_image': restImage,
      };
}

class RestaurantResponse {
  final bool success;
  final String message;

  RestaurantResponse({
    required this.success,
    required this.message,
  });

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantResponse(
      success: json['success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}

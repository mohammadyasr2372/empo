// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_clean_arichitecture/features_vendor/presentation/bloc/post_bloc/post_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../domain/entities/posts_entity/post_entity/craetepost_entity.dart';

// class AddPostScreen extends StatefulWidget {
//   @override
//   _AddPostScreenState createState() => _AddPostScreenState();
// }

// class _AddPostScreenState extends State<AddPostScreen> {
//   List<File> _images = [];
//   final picker = ImagePicker();
//   final PageController _pageController = PageController();
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController contentController = TextEditingController();
//   int _activePage = 0;

//   Future<void> _pickImages() async {
//     final pickedFiles = await picker.pickMultiImage();

//     setState(() {
//       if (pickedFiles != null && pickedFiles.isNotEmpty) {
//         _images.addAll(
//             pickedFiles.map((pickedFile) => File(pickedFile.path)).toList());
//         // final imagePaths =
//         //     _images.map((image) => image.path.split('/').last).toList();
//         // print('Images: $imagePaths');
//       }
//     });
//   }

//   void _removeImage(int index) {
//     setState(() {
//       _images.removeAt(index);
//     });
//   }

//   void _submitPost() async {
//     final title = titleController.text;
//     final content = contentController.text;
//     print('Title: $title');
//     print('Description: $content');

//     final imagePaths =
//         _images.map((image) => 'images/${image.path.split('/').last}').toList();
//     final imagePathsString = imagePaths.toString();

//     print('Images: $imagePaths');
//     // List<ImageEntity> imageEntity =
//     //     ImageEntity(id: imagePaths) as List<ImageEntity>;
//     // final imageEntities =
//     //     _images.map((image) => ImageEntity(id: image)).toList();

//     // DataPostEntity dataPostEntity = DataPostEntity(
//     //     title: title, content: content, images: imageEntities, shopperId: '');
//     // context.read<PostBloc>().add(
//     //       CreatePostEvent(dataPost: dataPostEntity),
//     //     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:
//             // BlocConsumer<PostBloc, PostState>(
//             //   listener: (context, state) {
//             //     if (state is SuccessPostsState) {
//             //       ScaffoldMessenger.of(context).showSnackBar(
//             //         SnackBar(content: Text(state.message)),
//             //       );
//             //     } else if (state is ErrorPostsState) {
//             //       ScaffoldMessenger.of(context).showSnackBar(
//             //         SnackBar(content: Text(state.message)),
//             //       );
//             //     }
//             //   },
//             //   builder: (context, state) {
//             //     return
//             Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           ImageSlider1(
//             images: _images,
//             pageController: _pageController,
//             pickImage: _pickImages,
//             removeImage: _removeImage,
//             activePage: _activePage,
//           ),
//           const SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 90.0),
//             child: ElevatedButton(
//               onPressed: _pickImages,
//               child: const Text('Add Images'),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 40),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 elevation: 10,
//                 shadowColor: Colors.grey,
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: titleController,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               labelText: 'Title',
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: contentController,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               labelText: 'Description',
//             ),
//             maxLines: 3,
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: _submitPost,
//             style: ElevatedButton.styleFrom(
//               // backgroundColor: Color.fromARGB(255, 103, 23, 121), // لون الخلفية
//               minimumSize: const Size(double.infinity, 60),
//               shape: RoundedRectangleBorder(
//                 side:
//                     const BorderSide(color: Color.fromARGB(255, 107, 106, 107)),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               elevation: 20,
//               shadowColor: Colors.grey,
//             ),
//             child: const Text(
//               'Submit Post',
//               style: TextStyle(
//                   color: Color.fromARGB(255, 96, 51, 106),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }

// class ImageSlider1 extends StatelessWidget {
//   final List<File> images;
//   final PageController pageController;
//   final VoidCallback pickImage;
//   final void Function(int) removeImage;
//   final int activePage;

//   const ImageSlider1({
//     Key? key,
//     required this.images,
//     required this.pageController,
//     required this.pickImage,
//     required this.removeImage,
//     required this.activePage,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height / 3.4,
//           child: images.isNotEmpty
//               ? PageView.builder(
//                   controller: pageController,
//                   itemCount: images.length,
//                   onPageChanged: (value) {},
//                   itemBuilder: (context, index) {
//                     return Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           //   bottomLeft: Radius.circular(20),
//                           //   bottomRight: Radius.circular(20),
//                           // ),
//                           child: Image.file(
//                             images[index],
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             height: double.infinity,
//                           ),
//                         ),
//                         Positioned(
//                           top: 10,
//                           right: 10,
//                           child: IconButton(
//                             icon: const Icon(Icons.remove_circle,
//                                 color: Colors.red),
//                             onPressed: () {
//                               removeImage(index);
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 )
//               : Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.grey,
//                   ),
//                   child: Center(
//                     child: IconButton(
//                       icon: const Icon(Icons.add_a_photo,
//                           color: Colors.white, size: 50),
//                       onPressed: pickImage,
//                       iconSize: 50,
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
//                         pageController.animateToPage(index,
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeIn);
//                       },
//                       child: CircleAvatar(
//                         radius: 4,
//                         backgroundColor: activePage == index
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
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../domain/entities/posts_entity/post_entity/craetepost_entity.dart';
// import '../../bloc/post_bloc/post_bloc.dart';

// class AddPostScreen extends StatefulWidget {
//   @override
//   _AddPostScreenState createState() => _AddPostScreenState();
// }

// class _AddPostScreenState extends State<AddPostScreen> {
//   List<File> _images = [];
//   final picker = ImagePicker();
//   final PageController _pageController = PageController();
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController contentController = TextEditingController();
//   int _activePage = 0;

//   Future<void> _pickImages() async {
//     final pickedFiles = await picker.pickMultiImage();

//     setState(() {
//       if (pickedFiles != null && pickedFiles.isNotEmpty) {
//         _images.addAll(
//             pickedFiles.map((pickedFile) => File(pickedFile.path)).toList());
//         print(_images);
//       }
//     });
//   }

//   void _removeImage(int index) {
//     setState(() {
//       _images.removeAt(index);
//     });
//   }

//   void _submitPost() {
//     final title = titleController.text;
//     final content = contentController.text;
//     BlocProvider.of<PostBloc>(context).add(CreatePostEvent(
//       dataPost: DataPostEntity(
//         title: title,
//         images: [],
//         content: content,
//         shopperId: 'shopperId',
//       ),
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//           // BlocProvider(
//           //   create: (context) => PostBloc(
//           //     createpostUsecase: createPostUsecase,
//           //     getallpostUsecase: getAllPostUsecase,
//           //     updatepostUsecase: updatePostUsecase,
//           //     deletepostIdUsecase: deletePostIdUsecase,
//           //   ),
//           //   child:
//           Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             BlocConsumer<PostBloc, PostState>(
//               listener: (context, state) {
//                 if (state is SuccessPostsState) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(state.message)),
//                   );
//                 } else if (state is ErrorPostsState) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(state.message)),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 if (state is loadingPostState) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 return Column(
//                   children: [
//                     ImageSlider(
//                       images: _images,
//                       pageController: _pageController,
//                       pickImage: _pickImages,
//                       removeImage: _removeImage,
//                       activePage: _activePage,
//                     ),
//                     SizedBox(height: 16),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 90.0),
//                       child: ElevatedButton(
//                         onPressed: _pickImages,
//                         child: Text('Add Images'),
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: Size(double.infinity, 40),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           elevation: 10,
//                           shadowColor: Colors.grey,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       controller: titleController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         labelText: 'Title',
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       controller: contentController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         labelText: 'Description',
//                       ),
//                       maxLines: 3,
//                     ),
//                     SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: _submitPost,
//                       child: Text(
//                         'Submit Post',
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 192, 100, 213),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(double.infinity, 60),
//                         shape: RoundedRectangleBorder(
//                           side: BorderSide(
//                             color: Color.fromARGB(255, 107, 106, 107),
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         elevation: 20,
//                         shadowColor: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ImageSlider extends StatelessWidget {
//   final List<File> images;
//   final PageController pageController;
//   final VoidCallback pickImage;
//   final void Function(int) removeImage;
//   final int activePage;

//   const ImageSlider({
//     Key? key,
//     required this.images,
//     required this.pageController,
//     required this.pickImage,
//     required this.removeImage,
//     required this.activePage,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height / 3.4,
//           child: images.isNotEmpty
//               ? PageView.builder(
//                   controller: pageController,
//                   itemCount: images.length,
//                   onPageChanged: (value) {},
//                   itemBuilder: (context, index) {
//                     return Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: Image.file(
//                             images[index],
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             height: double.infinity,
//                           ),
//                         ),
//                         Positioned(
//                           top: 10,
//                           right: 10,
//                           child: IconButton(
//                             icon: Icon(Icons.remove_circle, color: Colors.red),
//                             onPressed: () {
//                               removeImage(index);
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 )
//               : Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.grey,
//                   ),
//                   child: Center(
//                     child: IconButton(
//                       icon: const Icon(Icons.add_a_photo,
//                           color: Colors.white, size: 50),
//                       onPressed: pickImage,
//                       iconSize: 50,
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
//                         pageController.animateToPage(index,
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeIn);
//                       },
//                       child: CircleAvatar(
//                         radius: 4,
//                         backgroundColor: activePage == index
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
// }

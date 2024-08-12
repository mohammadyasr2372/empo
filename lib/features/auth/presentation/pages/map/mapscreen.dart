// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';

// class MapScreen extends StatefulWidget {
//   final LatLng? initialCameraPosition;

//   const MapScreen({Key? key, required this.initialCameraPosition})
//       : super(key: key);

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   LatLng? _selectedLocation;
//   String? _cityName;
//   int? newDeviceId;

//   Future<int?> _addNumber(String num1, String num2) async {
//     final String url = 'http://10.0.2.2:8001/numbers/add/';
//     Dio dio = Dio();
//     Map<String, dynamic> data = {
//       'num1': num1,
//       'num2': num2,
//     };
//     try {
//       final response = await dio.post(
//         url,
//         data: jsonEncode(data),
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       if (response.statusCode == 201) {
//         newDeviceId = response.data['id'];
//         print('Numbers added successfully with ID: $newDeviceId');
//         return newDeviceId;
//       } else {
//         throw Exception('Failed to add numbers');
//       }
//     } catch (e) {
//       if (e is DioError) {
//         print('DioError: ${e.message}');
//         if (e.response != null) {
//           print('DioError Response data: ${e.response?.data}');
//           print('DioError Response headers: ${e.response?.headers}');
//           print('DioError Response status code: ${e.response?.statusCode}');
//         }
//       } else {
//         print('Error: $e');
//       }
//       throw Exception('Failed to add numbers');
//     }
//   }

//   Future<void> _getCityName(LatLng latLng) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
//       if (placemarks.isNotEmpty) {
//         setState(() {
//           _cityName = placemarks.first.locality;
//         });
//         print('City Name: $_cityName');
//       }
//     } catch (e) {
//       print('Failed to get city name: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _selectedLocation != null
//             ? Text(
//                 'Location (${_selectedLocation!.latitude.toStringAsFixed(4)}, ${_selectedLocation!.longitude.toStringAsFixed(4)})')
//             : const Text('Location'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: widget.initialCameraPosition != null
//                 ? CameraPosition(
//                     target: widget.initialCameraPosition!,
//                     zoom: 11.5,
//                   )
//                 : const CameraPosition(
//                     target: LatLng(0, 0),
//                     zoom: 11.5,
//                   ),
//             onTap: (latLng) {
//               setState(() {
//                 _selectedLocation = latLng;
//               });
//                _getCityName(latLng);
//               if (_selectedLocation != null) {
//                 print('City Name: $_cityName');

//                 print(
//                     'Selected Location: ${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}');
//               }
//             },
//             markers: _selectedLocation != null
//                 ? {
//                     Marker(
//                       markerId: const MarkerId('selected_location'),
//                       position: _selectedLocation!,
//                     ),
//                   }
//                 : {},
//           ),
//           Positioned(
//             bottom: 16,
//             left: 16,
//             child: FloatingActionButton(
//               onPressed: () async {
//                 if (_selectedLocation != null) {
                  
//                   print('City Name: $_cityName');
//                   Navigator.pop(context, _selectedLocation);

//                   // try {
//                   //   final id = await _addNumber(
//                   //     _selectedLocation!.latitude.toStringAsFixed(14),
//                   //     _selectedLocation!.longitude.toStringAsFixed(14),
//                   //   );
//                   //   if (id != null) {
//                   //     // Print city name in the terminal
//                   // print('New Device ID: $id');

//                   //   }
//                   // } catch (e) {
//                   //   print('Failed to add numbers: $e');
//                   // }
//                 }
//               },
//               child: const Icon(Icons.check),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

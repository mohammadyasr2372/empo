// // ignore_for_file: unnecessary_null_comparison, use_key_in_widget_constructors, library_private_types_in_public_api

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../../data/model/report.dart';
// import 'mapscreen.dart';
// import 'mapscreenselected.dart';

// class HomeScreenmap extends StatefulWidget {
//   const HomeScreenmap({Key? key});

//   @override
//   _HomeScreenmapState createState() => _HomeScreenmapState();
// }

// class _HomeScreenmapState extends State<HomeScreenmap> {
//   LatLng? _selectedLocation;
//   double latitudeg = 0;
//   double longitudeg = 0;
//   LatLng? initialCameraPosition;
//   ReportLocation? reportLocation;
//   bool isLoading = true;
//   int? deviceId;

//   Future<void> _getCurrentAdministrativeArea() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         throw 'Location services are disabled.';
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           throw 'Location permissions are denied';
//         }
//       }
//       if (permission == LocationPermission.deniedForever) {
//         throw 'Location permissions are permanently denied, we cannot request permissions.';
//       }

//       Position position = await Geolocator.getCurrentPosition();
//       setState(() {
//         latitudeg = position.latitude;
//         longitudeg = position.longitude;
//         initialCameraPosition = LatLng(
//           position.latitude,
//           position.longitude,
//         );
//         isLoading = false;
//       });

//       print('Latitude: $latitudeg');
//       print('Longitude: $longitudeg');
//     } catch (e) {
//       print('Error fetching location: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentAdministrativeArea();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             if (isLoading)
//               const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             if (!isLoading)
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     final selectedLocation = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MapScreen(
//                           initialCameraPosition: initialCameraPosition,
//                         ),
//                       ),
//                     );
//                     if (selectedLocation != null) {
//                       setState(() {
//                         _selectedLocation = selectedLocation as LatLng?;
//                       });
//                       print(
//                           'Selected Location: ${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}');
//                     }
//                   },
//                   child: const Text('Select Location on Map'),
//                 ),
//               ),
//             if (_selectedLocation != null)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Selected Location: ${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//             if (_selectedLocation != null)
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_selectedLocation != null) {
//                     try {
//                       if (reportLocation != null) {
//                         print(
//                             '${reportLocation!.num1}, ${reportLocation!.num2}');
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => MapScreenSelected(
//                               initialLocation: LatLng(
//                                 double.parse(reportLocation!.num1!),
//                                 double.parse(reportLocation!.num2!),
//                               ),
//                               selectedLocation: _selectedLocation!,
//                             ),
//                           ),
//                         );
//                       } else {
//                         print('No report data available');
//                       }
//                     } catch (e) {
//                       print('Error fetching report: $e');
//                     }
//                   } else {
//                     print('No location selected');
//                   }
//                 },
//                 child: const Text('Go to Selected Location'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

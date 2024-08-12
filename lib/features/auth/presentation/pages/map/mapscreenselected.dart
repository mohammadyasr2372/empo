// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;

// class MapScreenSelected extends StatefulWidget {
//   final LatLng initialLocation;
//   final LatLng selectedLocation;

//   const MapScreenSelected(
//       {required this.initialLocation, required this.selectedLocation});

//   @override
//   _MapScreenSelectedState createState() => _MapScreenSelectedState();
// }

// class _MapScreenSelectedState extends State<MapScreenSelected> {
//   GoogleMapController? _googleMapController;
//   Set<Marker> _markers = {};
//   Set<Polyline> _polylines = {};
//   final String _apiKey = 'AIzaSyCqLFEHb7JwFM8K71RsSH3hN5HyowalI94';

//   @override
//   void dispose() {
//     _googleMapController?.dispose();
//     super.dispose();
//   }
//   Future<String?> _fetchRoutePolyline(LatLng origin, LatLng destination) async {
//     final String url =
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$_apiKey';

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = jsonDecode(response.body);
//       print(response.body);
//       if (data['routes'] != null && data['routes'].isNotEmpty) {
//         String routePolyline = data['routes'][0]['overview_polyline']['points'];
//         return routePolyline;
//       } else {
//         // Handle the case where there are no routes returned
//         print('Error: No routes found in Google Maps response.');
//         print(response.body);
//         return null;
//       }
//     } else {
//       print(response.body);
//       throw 'Failed to fetch route: ${response.statusCode}';
//     }
//   }
//   List<LatLng> _decodePoly(String encoded) {
//     List<LatLng> points = [];
//     int index = 0, len = encoded.length;
//     double lat = 0, lng = 0;

//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;

//       shift = 0;
//       result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;

//       points.add(LatLng(lat / 1e5, lng / 1e5));
//     }
//     return points;
//   }

//   Future<void> _drawRoute() async {
//     try {
//       String? routePolyline = await _fetchRoutePolyline(
//         widget.initialLocation,
//         widget.selectedLocation,
//       );

//       if (routePolyline != null) {
//         List<LatLng> polylinePoints = _decodePoly(routePolyline);

//         setState(() {
//           _polylines.add(Polyline(
//             polylineId: const PolylineId('route'),
//             points: polylinePoints,
//             color: Colors.red,
//             width: 5,
//           ));
//         });
//       }
//     } catch (e) {
//       print('Error fetching location or route: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     _markers.add(Marker(
//       markerId: const MarkerId('initial_location'),
//       position: widget.initialLocation,
//       infoWindow: const InfoWindow(title: 'Your Location'),
//     ));

//     _markers.add(Marker(
//       markerId: const MarkerId('selected_location'),
//       position: widget.selectedLocation,
//       infoWindow: const InfoWindow(title: 'Selected Location'),
//     ));

//     _drawRoute();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Selected Location'),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: widget.initialLocation,
//           zoom: 11.5,
//         ),
//         onMapCreated: (controller) {
//           _googleMapController = controller;
//         },
//         markers: _markers,
//         polylines: _polylines,
//         myLocationEnabled: true,
//         tiltGesturesEnabled: true,
//       ),
//     );
//   }
// }

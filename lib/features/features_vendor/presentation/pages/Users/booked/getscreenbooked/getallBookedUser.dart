import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../data/data_source/User_Shopper_datasource/user_datasource.dart';
import '../../../../../data/models/user_model/booked/getBookedWedding_model.dart';

class Getallbookeduser extends StatefulWidget {
  const Getallbookeduser({super.key});

  @override
  State<Getallbookeduser> createState() => _GetallbookeduserState();
}

class _GetallbookeduserState extends State<Getallbookeduser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Bookings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildBookingContainer("Wedding Halls", context, WeddingHallsPage()),
            const SizedBox(height: 10),
            buildBookingContainer("Restaurants", context, RestaurantsPage()),
            const SizedBox(height: 10),
            buildBookingContainer("Hotels", context, HotelsPage()),
            const SizedBox(height: 10),
            buildBookingContainer("Sweet Shops", context, SweetShopsPage()),
          ],
        ),
      ),
    );
  }

  Widget buildBookingContainer(String name, BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


// Wedding Halls Page
class WeddingHallsPage extends StatefulWidget {
  @override
  State<WeddingHallsPage> createState() => _WeddingHallsPageState();
}

class _WeddingHallsPageState extends State<WeddingHallsPage> {
  bool isLoading = true;
  GetbookedweddingModel? getbookedwedding;
  final UserDatasourceImp userDatasource = UserDatasourceImp(dio: Dio());

  @override
  void initState() {
    super.initState();
    _getBookedWedding(); // Load booked wedding data on initialization
  }

  Future<void> _getBookedWedding() async {
    try {
      final bookedwedding = await userDatasource.getbookedwedding();
      setState(() {
        getbookedwedding = bookedwedding;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wedding Halls"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: getbookedwedding?.detailsBooked.length ?? 0,
              itemBuilder: (context, index) {
                final detail = getbookedwedding!.detailsBooked[index];
                return buildListItem(
                  "Hall ${index + 1}",
                  "assets/hall${index + 1}.png",
                  detail.totalPrice,
                  detail.numberChairBooked,
                  detail.dateBooked,
                );
              },
            ),
    );
  }

  Widget buildListItem(String name, String imagePath, int? totalPrice, int? numberChairBooked, DateTime? dateBooked) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Total Price: \$${totalPrice ?? 0}",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            "Chairs Booked: ${numberChairBooked ?? 0}",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            "Date Booked: ${dateBooked != null ? "${dateBooked.day}-${dateBooked.month}-${dateBooked.year}" : "N/A"}",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
// Restaurants Page
class RestaurantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurants"),
      ),
      body: ListView(
        children: [
          buildListItem("Restaurant 1", "assets/photo.jpg"),
          buildListItem("Restaurant 2", "assets/photo.jpg"),
          buildListItem("Restaurant 3", "assets/photo.jpg"),
        ],
      ),
    );
  }
}

// Hotels Page
class HotelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotels"),
      ),
      body: ListView(
        children: [
          buildListItem("Hotel 2", "assets/photo.jpg"),
          buildListItem("Hotel 1", "assets/photo.jpg"),
          buildListItem("Hotel 3", "assets/photo.jpg"),
        ],
      ),
    );
  }
}

// Sweet Shops Page
class SweetShopsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sweet Shops"),
      ),
      body: ListView(
        children: [
          buildListItem("Sweet Shop 1", "assets/photo.jpg"),
          buildListItem("Sweet Shop 2", "assets/photo.jpg"),
          buildListItem("Sweet Shop 3", "assets/photo.jpg"),
        ],
      ),
    );
  }
}

// Function to build list items with image and name
Widget buildListItem(String name, String imagePath) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16.0),
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        ClipOval(
          child: Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

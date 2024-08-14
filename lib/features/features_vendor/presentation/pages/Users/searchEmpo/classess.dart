
import 'package:flutter/material.dart';

class GET_WeddingHall extends StatelessWidget {
  final String name;
  final String id;

  GET_WeddingHall({required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Text('Details for $name with ID $id'),
      ),
    );
  }
}

class RestaurantPage1 extends StatelessWidget {
  final String name;
  final String id;

  RestaurantPage1({required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Text('Details for $name with ID $id'),
      ),
    );
  }
}

class HotelPage1 extends StatelessWidget {
  final String name;
  final String id;

  HotelPage1({required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Text('Details for $name with ID $id'),
      ),
    );
  }
}

class SweetShopPage extends StatelessWidget {
  final String name;
  final String id;

  SweetShopPage({required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Text('Details for $name with ID $id'),
      ),
    );
  }
}

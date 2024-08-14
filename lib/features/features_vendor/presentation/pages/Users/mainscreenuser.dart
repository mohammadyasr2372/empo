// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import '../shopper/MainScreenShopper.dart';
import '../posts/getallpost/getpagepost.dart';
import '../profilescreen.dart';
import 'booked/getscreenbooked/getallBookedUser.dart';
import 'profileuser.dart';
import 'searchEmpo/searchEmpo.dart';
import 'searchuser.dart';

class MainScreenUser extends StatefulWidget {
  @override
  _MainScreenUserState createState() => _MainScreenUserState();
}

class _MainScreenUserState extends State<MainScreenUser> {
  int _selectedIndex = 0;

  static List<Widget> _screens = [
    PostsPage(),
    SearchScreen(),
    EMPOApp(),
    Getallbookeduser(),
    ProfileScreenUser(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box_outlined,
                size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.event_available,
              ),
              label: 'Reservations',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
          backgroundColor: Colors.deepPurpleAccent,
          unselectedItemColor: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}

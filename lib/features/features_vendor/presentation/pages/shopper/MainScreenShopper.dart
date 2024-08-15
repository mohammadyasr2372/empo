// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/strings/constans.dart';
import '../../../../../injection_container.dart';
import '../../../../hotel/presentation/pages/hotel/post_hotel/add_room_hotel.dart';
import '../Users/searchEmpo/searchEmpo.dart';
import '../posts/posts_page.dart/pageposts.dart';
import '../profilescreen.dart';
import '../posts/getallpost/getpagepost.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    PostsPage(),
    const AddRoomHotel(),
    AddPostScreen(),
    const AccountScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _widjetpost() {
    String temp = sl.get<SharedPreferences>().getString(CACHED_TYPE_SHOPPER)!;
    print(temp);
    if (temp == 'Wedding Hall') {
      return AddRoomHotel();
    } else if (temp == 'Hotal') {
      return AddRoomHotel();
    } else if (temp == 'Candies shop') {
      return AddRoomHotel();
    } else if (temp == 'Restorant') {
      return AddRoomHotel();
    } else {
      return Scaffold();
    }
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

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Favorites Screen', style: TextStyle(color: Colors.white)));
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Account Screen', style: TextStyle(color: Colors.white)));
  }
}

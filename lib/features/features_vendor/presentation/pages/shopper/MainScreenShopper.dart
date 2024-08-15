// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/strings/constans.dart';
import '../../../../../injection_container.dart';
import '../../../../hotel/presentation/pages/hotel/post_hotel/add_room_hotel.dart';
import '../Users/searchEmpo/searchEmpo.dart';
import '../cande/post_cande/add_sweet_cande.dart';
import '../posts/posts_page.dart/pageposts.dart';
import '../profilescreen.dart';
import '../posts/getallpost/getpagepost.dart';
import '../restaurant/post_restaurant/add_food_rest.dart';
import '../wedding_hall/post_wedding_hall/post_image_hospit.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String temp = sl.get<SharedPreferences>().getString(CACHED_TYPE_SHOPPER)!;
  static final List<Widget> _screens = [
    PostsPage(),
    PostInfo(),
    AddPostScreen(),
    const AccountScreen(),
    const ProfileScreen(),
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

class PostInfo extends StatelessWidget {
  const PostInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height,
        ),
        child: ListView(
          children: [
            Builder(
              builder: (BuildContext context) {
                String? cachedType =
                    sl.get<SharedPreferences>().getString(CACHED_TYPE_SHOPPER);

                if (cachedType == 'Wedding Hall') {
                  return SizedBox(
                    height: height, // تحديد ارتفاع محدد
                    child: PostImageHospit(),
                  );
                } else if (cachedType == 'Hotal') {
                  return SizedBox(
                    height: height, // تحديد ارتفاع محدد
                    child: AddRoomHotel(),
                  );
                } else if (cachedType == 'Candies shop') {
                  return const SizedBox(
                    height: 400.0, // تحديد ارتفاع محدد
                    child: AddSweetCande(),
                  );
                } else if (cachedType == 'Restaurant') {
                  return const SizedBox(
                    height: 400.0, // تحديد ارتفاع محدد
                    child: AddFoodRestaurant(),
                  );
                } else {
                  return Switch(
                    value: cachedType != null,
                    onChanged: (bool value) {
                      // معالجة تغيير قيمة السويتش
                    },
                  );
                }
              },
            ),
          ],
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
        child: Text('Account Screen',
            style: TextStyle(color: Color.fromARGB(255, 144, 27, 27))));
  }
}

import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../data/data_source/User_Shopper_datasource/user_datasource.dart';

class SearchSection extends StatefulWidget {
  final String title;
  final TextEditingController searchController;
  final List<Map<String, String>> items;

  SearchSection({
    required this.title,
    required this.searchController,
    required this.items,
  });

  @override
  _SearchSectionState createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  List<Map<String, String>> filteredItemss = [];
  final UserDatasourceImp userDatasource = UserDatasourceImp(dio: Dio());

  @override
  void initState() {
    super.initState();
    filteredItemss = widget.items;
  }

  // Future<void> getCitiesData(String city) async {
  //   try {
  //     final cityData = await userDatasource.searchcity(city);
  //     setState(() {
  //       filteredItemss = cityData
  //           .map((item) => {
  //                 'name': item['name'],
  //                 'imagePath': item['imagePath'],
  //               })
  //           .toList();
  //     });
  //   } catch (e) {
  //     print(e);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error fetching city data')),
  //     );
  //   }
  // }

  void _filterItems(String price, String vendor) async {
    if (price.isEmpty || vendor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both price and vendor type')),
      );
      return;
    }

    try {
      final searchPriceResult =
          await userDatasource.searchpriceUser(price, vendor);
      if (!searchPriceResult.success!) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(searchPriceResult.message ?? 'Unknown error occurred')),
        );
        return;
      }

      List<Map<String, String>> updatedItems = [];

      for (var data in searchPriceResult.data) {
        for (var shopperId in data.shopperId) {
          final shopperData =
              await userDatasource.getDataShopperUser(shopperId);
          if (shopperData.success == true && shopperData.data != null) {
            updatedItems.add({
              'name': shopperData.data!.eventName ?? 'Unknown',
              'imagePath': shopperData.data!.image ?? '',
              'shopperId': shopperId,
            });
          }
        }
      }

      setState(() {
        filteredItemss = updatedItems;
      });
    } catch (e) {
      print("Error fetching shopper data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching shopper data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageController _pageController =
        PageController(initialPage: 0, viewportFraction: 0.8);

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: widget.searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Search ${widget.title}',
                ),
                onChanged: (query) {
                  _filterItems(query, widget.title);
                },
              ),
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 230,
            child: PageView.builder(
              controller: _pageController,
              itemCount: filteredItemss.length,
              itemBuilder: (context, index) {
                final item = filteredItemss[index];
                final name = item['name'] ?? 'No Name';
                final imagePath = item['imagePath'] ?? '';

                return GestureDetector(
                  onTap: () {},
                  child: RoomCarouselView1(
                    imagePath: imagePath,
                    imageName: name,
                    controller: _pageController,
                    index: index,
                    filteredItems: filteredItemss,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Divider(),
        ],
      ),
    );
  }
}

class RoomCarouselView1 extends StatelessWidget {
  final String imagePath;
  final String imageName;
  final PageController controller;
  final int index;
  final List<Map<String, String>> filteredItems;

  const RoomCarouselView1({
    Key? key,
    required this.imagePath,
    required this.imageName,
    required this.controller,
    required this.index,
    required this.filteredItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 0.0;
        if (controller.position.haveDimensions) {
          value = index.toDouble() - (controller.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
        }
        return Transform.rotate(
          angle: pi * value,
          child: RoomCarouselCard1(
            imagePath: imagePath,
            imageName: imageName,
          ),
        );
      },
    );
  }
}

class RoomCarouselCard1 extends StatelessWidget {
  final String imagePath;
  final String imageName;

  const RoomCarouselCard1({
    Key? key,
    required this.imagePath,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                          'http://localhost:3000/${imagePath.split('/').last}'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    color: Colors.black54,
                    child: Text(
                      imageName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

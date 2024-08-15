import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_arichitecture/features_vendor/data/data_source/constBase_URL.dart';

import '../../../data/data_source/candiesshop_datasource/candiesShop_datasource.dart';
import '../../../data/models/candeisshop_model/getSweet.dart';
import '../../../data/models/candeisshop_model/getcandyShop_model.dart';

import '../../widgets/BookingButton.dart';

import '../../widgets/widget_restaurant/widget_get/menu_carousel_card.dart';
import '../stars_hall.dart';
import '../restaurant/get_restaurant/hospitality_images_section.dart';
import 'imageplaceholder.dart';

class CandiesShopPage extends StatefulWidget {
  @override
  State<CandiesShopPage> createState() => _CandiesShopPageState();
}

class _CandiesShopPageState extends State<CandiesShopPage> {
  bool isLoading = true;
  String? errorMessage;
  final CandiesshopDatasourceImpl candiesShopDatasource =
      CandiesshopDatasourceImpl(dio: Dio());
  GetcandyshopModel? getCandyshop;

  @override
  void initState() {
    super.initState();
    fetchRestaurantDetails();
  }

  Future<void> fetchRestaurantDetails() async {
    try {
      final getInfo = await candiesShopDatasource.getCandiesShop_datasourece();
      setState(() {
        getCandyshop = getInfo;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching restaurant details: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(errorMessage!)),
      );
    }

    // Assuming the data model for `GetCandyshopModel` has an accessible structure
    final restaurantData = getCandyshop!.data;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Displaying the fetched images
            ImagesSectionCandies(
              data: restaurantData!,
            ),
            // Hall Information Section
            // InformationSection(), // You can pass relevant data to this widget if needed
            // Hospitality Images Section with prices
            HospitalityImagesSection1(),
            // Booking Button
            BookingButton(onPressed: () {
              // Implement navigation to booking page
            }),
          ],
        ),
      ),
    );
  }
}
class HospitalityImagesSection1 extends StatefulWidget {
  @override
  State<HospitalityImagesSection1> createState() =>
      _HospitalityImagesSection1State();
}

class _HospitalityImagesSection1State extends State<HospitalityImagesSection1> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  bool isLoading = true;
  String? errorMessage;
  final CandiesshopDatasourceImpl candiesShopDatasource =
      CandiesshopDatasourceImpl(dio: Dio());
  GetcandyshopModel? getCandyshop;
  Getsweet? sweet;

  @override
  void initState() {
    super.initState();
    getCandiesShopDetails();
  }

  Future<void> getCandiesShopDetails() async {
    try {
      final getInfo = await candiesShopDatasource.getCandiesShop_datasourece();
      final getSweetInfo = await candiesShopDatasource
          .getSweet_datasourece('66bc4087ad3d3b1002e70b32');
      setState(() {
        getCandyshop = getInfo;
        sweet = getSweetInfo;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching details: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Text(
                'Capacity: ${getCandyshop?.data?.avargSweet ?? 'N/A'}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 110),
              Text(
                'Price Table: ${getCandyshop?.data?.dataOpen ?? 'N/A'}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Menu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        SizedBox(
          height: 240,
          child: PageView.builder(
            controller: _pageController,
            itemCount: sweet?.dataProducts.length ?? 0, // تأكد من العدد الصحيح
            itemBuilder: (context, index) {
              final product = sweet?.dataProducts[index];
              if (product == null) return SizedBox.shrink();
              final imageUrl = product.sweetImage.isNotEmpty ? product.sweetImage[0].url : null;

              return MenuCarouselviewcandies(
                imagePath: imageUrl ?? '',  // تأكد من عدم وجود قيم فارغة
                controller: _pageController,
                index: index,
                price: product.sweetPrice ?? 0,  // توفير قيمة افتراضية
                Name: product.sweetName ?? 'N/A',
                amount: product.sweetAmont ?? 0,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}


class MenuCarouselviewcandies extends StatelessWidget {
  final String imagePath;
  final PageController controller;
  final int index;
  final int price;
  final int amount;
  final String Name;

  const MenuCarouselviewcandies({
    Key? key,
    required this.imagePath,
    required this.controller,
    required this.index,
    required this.price,
    required this.Name,
    required this.amount,
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
          child: Stack(
            children: [
              MenuCarouselCardCandies(imagePath: imagePath),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  // color: Colors.black54,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        '\$$price', // عرض السعر هنا
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        '$Name', // عرض السعر هنا
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '$amount', // عرض السعر هنا
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MenuCarouselCardCandies extends StatelessWidget {
  final String imagePath;

  const MenuCarouselCardCandies({Key? key, required this.imagePath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(imagePath);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage('${BASE_URL}${imagePath.split('/').last}'),
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
    );
  }
}

// class MenuCarouselCard extends StatelessWidget {
//   final String imagePath;

//   const MenuCarouselCard({Key? key, required this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           image: DecorationImage(
//             image: NetworkImage(
//                 'http://localhost:3000/${imagePath.split('/').last}'),
//             fit: BoxFit.cover,
//           ),
//           boxShadow: const [
//             BoxShadow(
//               offset: Offset(0, 4),
//               blurRadius: 4,
//               color: Colors.black26,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

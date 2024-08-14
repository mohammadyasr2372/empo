import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../data/data_source/restaurnat_data_source/resturant_datasource.dart';
import '../../../../data/models/restaurant_model/getdetails_restorant/getinforestorant.dart';
import '../../../../data/models/restaurant_model/getfood.dart';
import '../../../widgets/widget_restaurant/widget_get/Menu_Carousel_view.dart';

class HospitalityImagesSection extends StatefulWidget {
  HospitalityImagesSection({Key? key}) : super(key: key);

  @override
  State<HospitalityImagesSection> createState() =>
      _HospitalityImagesSectionState();
}

class _HospitalityImagesSectionState extends State<HospitalityImagesSection> {
  final PageController _PageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  bool isLoading = true;
  String? errorMessage;
  ResturantDatasourceImpl resturantDatasource =
      ResturantDatasourceImpl(dio: Dio());
  Getinforestorant? inforestorant;
  Getfood? food;
 String? ID;
  @override
  void initState() {
    super.initState();
    fetchRestaurantDetails();
  }

  Future<void> fetchRestaurantDetails() async {
    try {
      final getinfo =
          await resturantDatasource.getresturantdetails_datasourece();
              final getfood =
          await resturantDatasource.getfood_datasourece('66b5d1ce0969ec14d7f6d7a5');
      setState(() {
        inforestorant = getinfo;
        food=getfood;
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
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    // Guard against null data
    if (inforestorant == null ||
        inforestorant!.data == null ||
        inforestorant!.data!.restImage.isEmpty) {
      return const Center(child: Text("No data available"));
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
                'Capacity: ${inforestorant!.data!.allTable ?? 'N/A'}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 110),
              Text(
                'Price Table: ${inforestorant!.data!.priceTable ?? 'N/A'}',
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
            controller: _PageController,
            itemCount: inforestorant!.data!.restImage.length,
            itemBuilder: (context, index) {
              return MenuCarouselview(
                imagePath:
                    'http://localhost:3000/${food!.dataProducts!.foodImage.first!.url!}',
                controller: _PageController,
                index: index,
                price: food!.dataProducts!.foodPrice!, Name: food!.dataProducts!.foodName!, // Adjust price or get dynamically if available
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

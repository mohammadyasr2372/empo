import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../data/data_source/constBase_URL.dart';
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
      final getinfo = await resturantDatasource.getresturantdetails_datasourece();
      setState(() {
        inforestorant = getinfo;
        ID = inforestorant?.data?.id; // حفظ الـ ID هنا
      });
      await fetchgetfoodDetails(); // استدعاء fetchgetfoodDetails بعد حفظ الـ ID
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching restaurant details: $e';
        isLoading = false;
      });
    }
  }

  Future<void> fetchgetfoodDetails() async {
    if (ID == null) { // تحقق من وجود الـ ID
      setState(() {
        errorMessage = 'Restaurant details not loaded properly';
        isLoading = false;
      });
      return;
    }

    try {
      final getfood = await resturantDatasource.getfood_datasourece(ID!); // استخدام الـ ID هنا
      setState(() {
        food = getfood;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching food details: $e';
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

    if (food == null || food!.dataProducts.isEmpty) {
      return const Center(child: Text("No food data available"));
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
                'Capacity: ${inforestorant?.data?.allTable ?? 'N/A'}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 110),
              Text(
                'Price Table: ${inforestorant?.data?.priceTable ?? 'N/A'}',
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
            itemCount: food!.dataProducts.length,
            itemBuilder: (context, index) {
              final product = food!.dataProducts[index];
              return MenuCarouselview(
                imagePath: '${BASE_URL}${product.foodImage.first.url}', // عرض الصورة الأولى في القائمة
                controller: _PageController,
                index: index,
                price: product.foodPrice!,
                Name: product.foodName!,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

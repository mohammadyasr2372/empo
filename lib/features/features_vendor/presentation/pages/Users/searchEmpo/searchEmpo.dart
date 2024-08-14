// ignore_for_file: unnecessary_null_comparison

import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/data_source/User_Shopper_datasource/user_datasource.dart';
import '../../../../data/models/user_model/search_user/getcity_model.dart';
import '../weather/bloc/weather_bloc.dart';
import '../weather/data_provider/weather_data_provider.dart';
import '../weather/repository/weather_repostory.dart';
import 'detailspage.dart';
import 'drop.dart';

class EMPOApp extends StatelessWidget {
  const EMPOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(
            WeatherRepository(
              WeatherDataProvider(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'EMPO App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedEvent;
  String? _selectedCity;
  final _numberController = TextEditingController();
  GetcityModel? Getcity;

  @override
  void initState() {
    super.initState();
    getcity();
  }

  final List<String> events = [
    'Wedding',
    'Birthday',
    'Work Party',
    'Graduation Party',
    'Public Party'
  ];
  Future<void> getcity() async {
    try {
      final cities = await userDatasource.getcity_datasource();
      setState(() {
        Getcity = cities;
      });
    } catch (e) {
      print(e);
    }
  }

  List<Map<String, String>> filteredItems = [];

  void _navigateToDetails() {
    if (_selectedEvent != null &&
        _selectedCity != null &&
        _numberController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsPage(
            selectedEvent: _selectedEvent!,
            selectedCity: _selectedCity!,
            number: _numberController.text,
            filteredItems: filteredItems,
          ),
        ),
      );
    }
  }

  final UserDatasourceImp userDatasource = UserDatasourceImp(dio: Dio());

  Future<void> getcities(String city, String eventType) async {
    try {
      final cityData = await userDatasource.searchcity(city);
      setState(() {
        filteredItems = [];

        if (cityData.success!) {
          List<Map<String, String>> allItems = [];

          if (eventType == 'Wedding' || eventType == 'Birthday') {
            if (cityData.dataWidding != null) {
              allItems.addAll(cityData.dataWidding
                  .map((item) => {
                        'name': item.eventName ?? '',
                        'imagePath': item.image ?? '',
                        'type': 'Wedding Hall'
                      })
                  .toList());
            }
          }

          if (eventType == 'Wedding' || eventType == 'Work Party') {
            if (cityData.dataHotal != null) {
              allItems.addAll(cityData.dataHotal
                  .map((item) => {
                        'name': item.eventName ?? '',
                        'imagePath': item.image ?? '',
                        'type': 'Hotal'
                      })
                  .toList());
            }
          }

          if (eventType == 'Birthday' || eventType == 'Work Party') {
            if (cityData.dataRestorant != null) {
              allItems.addAll(cityData.dataRestorant
                  .map((item) => {
                        'name': item.eventName ?? '',
                        'imagePath': item.image ?? '',
                        'type': 'Restorant'
                      })
                  .toList());
            }
          }

          if (eventType == 'Wedding' || eventType == 'Birthday') {
            if (cityData.datacandshop != null) {
              allItems.addAll(cityData.datacandshop
                  .map((item) => {
                        'name': item.eventName ?? '',
                        'imagePath': item.image ?? '',
                        'type': 'Candies shop'
                      })
                  .toList());
            }
          }

          if (eventType == 'Graduation Party' || eventType == 'Public Party') {
            if (cityData.dataWidding != null) {
              allItems.addAll(cityData.dataWidding
                  .map((item) => {
                        'name': item.eventName ?? '',
                        'imagePath': item.image ?? '',
                        'type': 'Wedding Hall'
                      })
                  .toList());
            }
            if (cityData.dataHotal != null) {
              allItems.addAll(cityData.dataHotal
                  .map((item) => {
                        'name': item.eventName ?? '',
                        'imagePath': item.image ?? '',
                        'type': 'Hotal'
                      })
                  .toList());
            }
            if (cityData.dataRestorant != null) {
              allItems.addAll(cityData.dataRestorant
                  .map((item) => {
                        'name': item.eventName ?? '',
                        'imagePath': item.image ?? '',
                        'type': 'Restorant'
                      })
                  .toList());
            }
            if (cityData.datacandshop != null) {
              allItems.addAll(cityData.datacandshop
                  .map((item) => {
                        'name': item.eventName ?? '',
                        'imagePath': item.image ?? '',
                        'type': 'Candies shop'
                      })
                  .toList());
            }
          }

          filteredItems = allItems;
        }
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'EMPO',
              style: GoogleFonts.lobster(
                textStyle: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 183, 4, 243),
                  shadows: [
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(150, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownWidget(
              hint: 'Select Event',
              value: _selectedEvent,
              items: events,
              onChanged: (value) {
                setState(() {
                  _selectedEvent = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownWidget(
              hint: 'Select City',
              value: _selectedCity,
              items: Getcity?.city ?? [],
              onChanged: (value) async {
                setState(() {
                  _selectedCity = value!;
                  context
                      .read<WeatherBloc>()
                      .add(WeatherFetched(_selectedCity!));
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Enter numbers',
              ),
            ),
            const SizedBox(height: 90),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 70,
              child: ElevatedButton(
                onPressed: () async {
                  if (_selectedEvent != null && _selectedCity != null) {
                    await getcities(_selectedCity!, _selectedEvent!);
                    _navigateToDetails();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Please select an event and a city')),
                    );
                  }
                },
                child: Text(
                  'Continue',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  // Future<void> getcities(String city) async {
  //   try {
  //     final cityy = await userDatasource.searchcity(city);
  //     if (_selectedEvent != null) {
  //       // _filterItems(_selectedEvent!, cityy);
  //     }
  //   } catch (e) {
  //     print(e);
  //     // Optionally show an error dialog
  //   }
  // }

  // Future<void> getcities(String city) async {
  //   try {
  //     final cityData = await userDatasource.searchcity(city);
  //     setState(() {
  //       filteredItems = [];

  //       if (cityData.success!) {
  //         // إضافة جميع البيانات إلى filteredItems
  //         if (cityData.dataWidding != null) {
  //           filteredItems.addAll(cityData.dataWidding!
  //               .map((item) => {
  //                     'name': item.eventName ?? '',
  //                     'imagePath': item.image ?? '1',
  //                     'type': 'Wedding Hall'
  //                   })
  //               .toList());
  //         }
  //         if (cityData.dataHotal != null) {
  //           filteredItems.addAll(cityData.dataHotal!
  //               .map((item) => {
  //                     'name': item.eventName ?? '',
  //                     'imagePath': item.image ?? '1',
  //                     'type': 'Hotal'
  //                   })
  //               .toList());
  //         }
  //         if (cityData.dataRestorant != null) {
  //           filteredItems.addAll(cityData.dataRestorant!
  //               .map((item) => {
  //                     'name': item.eventName ?? '',
  //                     'imagePath': item.image ?? '1',
  //                     'type': 'Restorant'
  //                   })
  //               .toList());
  //         }
  //         if (cityData.datacandshop != null) {
  //           filteredItems.addAll(cityData.datacandshop!
  //               .map((item) => {
  //                     'name': item.eventName ?? '',
  //                     'imagePath': item.image ?? '1',
  //                     'type': 'Candies shop'
  //                   })
  //               .toList());
  //         }
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error fetching data')),
  //     );
  //   }
  // }
  // void _filterItems(String event) {
  //   setState(() {
  //     // إنشاء قائمة جديدة للفلاتر
  //     List<Map<String, String>> tempFilteredItems = [];

  //     switch (event) {
  //       case 'Wedding':
  //         // عرض صالات الزفاف، الفنادق، ومحلات الحلوى
  //         tempFilteredItems.addAll(filteredItems.where((item) =>
  //             item['type'] == 'Wedding Hall' ||
  //             item['type'] == 'Hotal' ||
  //             item['type'] == 'Candies shop'));
  //         break;
  //       case 'Birthday':
  //         // عرض المطاعم، الصالات، ومحلات الحلوى
  //         tempFilteredItems.addAll(filteredItems.where((item) =>
  //             item['type'] == 'Restorant' ||
  //             item['type'] == 'Wedding Hall' ||
  //             item['type'] == 'Candies shop'));
  //         break;
  //       case 'Work Party':
  //         // عرض المطاعم والفنادق
  //         tempFilteredItems.addAll(filteredItems.where((item) =>
  //             item['type'] == 'Restorant' || item['type'] == 'Hotal'));
  //         break;
  //       case 'Graduation Party':
  //       case 'Public Party':
  //         tempFilteredItems.addAll(filteredItems);
  //         break;
  //       default:
  //         tempFilteredItems = []; // إذا لم يكن هناك حدث محدد
  //     }

  //     // تحديث filteredItems مع العناصر التي تم فلترتها
  //     filteredItems = tempFilteredItems;
  //   });
  // }
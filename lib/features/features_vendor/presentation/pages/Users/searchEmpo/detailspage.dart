import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import '../weather/bloc/weather_bloc.dart';
import '../weather/screens/widget/HourlyForecastItem.dart';
import 'searchsection.dart';

class DetailsPage extends StatefulWidget {
  final String selectedEvent;
  final String selectedCity;
  final String number;
  final List<Map<String, String>> filteredItems;

  DetailsPage({
    required this.selectedEvent,
    required this.selectedCity,
    required this.number,
    required this.filteredItems,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  String? _selectedCity;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 157, 86, 196),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        if (state is WeatherFailure) {
                          return Center(
                            child: Text(state.error),
                          );
                        }

                        if (state is! WeatherSuccess) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }

                        final data = state.weatherModel;
                        final currentTemp = data.currentTemp;
                        final currentSky = data.currentSky;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${(currentTemp - 273.15).toStringAsFixed(0)} °C',
                                  style: GoogleFonts.lobster(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  currentSky == 'Clouds'
                                      ? Icons.cloud
                                      : currentSky == 'Rain'
                                          ? FontAwesome.a_solid
                                          : Icons.sunny,
                                  size: 20,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                currentSky,
                                style: GoogleFonts.lobster(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Hourly Forecast',
                              style: GoogleFonts.lobster(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 84,
                              child: ListView.builder(
                                itemCount: data.hourlyForecasts.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final hourlyForecast =
                                      data.hourlyForecasts[index];

                                  final hourlySky = hourlyForecast.skyCondition;
                                  final hourlyTemp =
                                      hourlyForecast.temperature.toString();
                                  final time = hourlyForecast.time;
                                  return HourlyForecastItem(
                                    time: DateFormat.j().format(time),
                                    temperature: hourlyTemp,
                                    skyCondition: hourlySky == 'Clouds'
                                        ? Icons.cloud
                                        : hourlySky == 'Rain'
                                            ? FontAwesome.a_solid
                                            : Icons.sunny,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 60),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.selectedEvent,
                          style: GoogleFonts.lobster(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.selectedCity,
                          style: GoogleFonts.lobster(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.number,
                          style: GoogleFonts.lobster(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  if (widget.filteredItems
                      .any((item) => item['type'] == 'Restorant'))
                    SearchSection(
                      title: 'Restorant',
                      searchController: TextEditingController(),
                      items: widget.filteredItems
                          .where((item) => item['type'] == 'Restorant')
                          .toList(),
                    ),
                  if (widget.filteredItems
                      .any((item) => item['type'] == 'Wedding Hall'))
                    SearchSection(
                      title: 'Wedding Hall',
                      searchController: TextEditingController(),
                      items: widget.filteredItems
                          .where((item) => item['type'] == 'Wedding Hall')
                          .toList(),
                    ),
                  if (widget.filteredItems
                      .any((item) => item['type'] == 'Hotal'))
                    SearchSection(
                      title: 'Hotal',
                      searchController: TextEditingController(),
                      items: widget.filteredItems
                          .where((item) => item['type'] == 'Hotal')
                          .toList(),
                    ),
                  if (widget.filteredItems
                      .any((item) => item['type'] == 'Candies shop'))
                    SearchSection(
                      title: 'Candies shop',
                      searchController: TextEditingController(),
                      items: widget.filteredItems
                          .where((item) => item['type'] == 'Candies shop')
                          .toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class DetailsPage extends StatefulWidget {
//   final String selectedEvent;
//   final String selectedCity;
//   final String number;
//   final List<Map<String, String>> filteredItems;

//   DetailsPage({
//     required this.selectedEvent,
//     required this.selectedCity,
//     required this.number,
//     required this.filteredItems,
//   });

//   @override
//   _DetailsPageState createState() => _DetailsPageState();
// }

// class _DetailsPageState extends State<DetailsPage> {
//   final PageController _pageController = PageController(initialPage: 0, viewportFraction: 0.8);

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             // بقية الكود لعرض معلومات الطقس والحدث والمدينة
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView(
//                 children: [
//                   if (widget.filteredItems.isNotEmpty)
//                     ...widget.filteredItems.map((item) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Card(
//                           child: ListTile(
//                             leading: Image.network(
//                               'http://localhost:3000/${item['imagePath']?.split('/').last}',
//                               fit: BoxFit.cover,
//                               width: 50,
//                               height: 50,
//                             ),
//                             title: Text(item['name'] ?? 'No Name'),
//                             subtitle: Text(item['type'] ?? 'No Type'),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
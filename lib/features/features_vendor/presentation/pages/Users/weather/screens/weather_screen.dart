// // ignore_for_file: avoid_print, await_only_futures
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:intl/intl.dart';

// import '../../searchEmpo.dart';
// import '../bloc/weather_bloc.dart';
// import '../data_provider/weather_data_provider.dart';
// import '../models/weather_model.dart';
// import '../repository/weather_repostory.dart';

// List<String> itemList = [
//   'damascus',
//   'London',
//   'New york city',
//   'jaramanah',
//   'Dubai',
//   'Abu Dhabi',
//   'Cairo',
//   'Madrid',
// ];
// String selectedItemValue = 'damascus';

// class WeatherScreen extends StatefulWidget {
//   const WeatherScreen({super.key});

//   @override
//   State<WeatherScreen> createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   WeatherModel? weather;

//   //   static Future<List<HourlyForecast>?> getWeatherModel() async {
//   //   final box = await Hive.openBox<WeatherModel>('cityBox');
//   //   final cityBox = box.get('city') as WeatherModel?;
//   //   return cityBox?.hourlyForecasts;
//   // }

//   @override
//   void setState(VoidCallback fn) {
//     context.read<WeatherBloc>().add(WeatherFetched());
//     //_loadCity();
//     super.setState(fn);
//   }

//   @override
//   void initState() {
//     super.initState();
//     context.read<WeatherBloc>().add(WeatherFetched());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Weather App',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 context.read<WeatherBloc>().add(WeatherFetched());
//               });
//             },
//             icon: const Icon(Icons.refresh),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           DropdownButton<String>(
//             value: selectedItemValue,
//             onChanged: (item) async {
//               try {
//                 setState(() {
//                   selectedItemValue = item!;
//                   context.read<WeatherBloc>().add(WeatherFetched());
//                 });
//                 WeatherRepository weatherRepository =
//                     WeatherRepository(WeatherDataProvider());
//                 final weather = await weatherRepository
//                     .getCurrentWeather(selectedItemValue);
//                 print('Weather in $selectedItemValue: $weather');
//               } catch (e) {
//                 print('Error fetching weather data: $e');
//               }
//             },
//             items: itemList.map<DropdownMenuItem<String>>((item) {
//               return DropdownMenuItem<String>(
//                 value: item,
//                 child: Text(
//                   item,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 19,
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//       body: BlocBuilder<WeatherBloc, WeatherState>(
//         builder: (context, state) {
//           if (state is WeatherFailure) {
//             print('object');
//             return Center(
//               child: Text(state.error),
//             );
//           }

//           if (state is! WeatherSuccess) {
//             return const Center(
//               child: CircularProgressIndicator.adaptive(),
//             );
//           }

//           final data = state.weatherModel;
//           final currentTemp = data.currentTemp;
//           final currentSky = data.currentSky;
//           final currentPressuree = data.currentPressure;
//           final currentWindSpeedd = data.currentWindSpeed;
//           final currentHumidityy = data.currentHumidity;

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // main card
//                 SizedBox(
//                   width: double.infinity,
//                   child: Card(
//                     elevation: 10,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(
//                           sigmaX: 10,
//                           sigmaY: 10,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             children: [
//                               Text(
//                                 '${(currentTemp - 273.15).toStringAsFixed(0)} °C',
//                                 style: const TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Icon(
//                                 currentSky == 'Clouds' || currentSky == 'Rain'
//                                     ? Icons.cloud
//                                     : Icons.sunny,
//                                 size: 64,
//                               ),
//                               const SizedBox(height: 16),
//                               Text(
//                                 currentSky,
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Hourly Forecast',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 SizedBox(
//                   height: 120,
//                   child: ListView.builder(
//                     itemCount: data.hourlyForecasts.length,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) {
//                       final hourlyForecast = data.hourlyForecasts[index];

//                       final hourlySky = hourlyForecast.skyCondition;
//                       final hourlyTemp = hourlyForecast.temperature.toString();
//                       final time = hourlyForecast.time;

//                       return HourlyForecastItem(
//                         time: DateFormat.j().format(time),
//                         temperature: hourlyTemp,
//                         skyCondition:
//                             hourlySky == 'Clouds' || hourlySky == 'Rain'
//                                 ? Icons.cloud
//                                 : Icons.sunny,
//                       );
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 20),
//                 const Text(
//                   'Additional Information',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 // const SizedBox(height: 8),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 //   children: [
//                 //     AdditionalInfoItem(
//                 //       icon: Icons.water_drop,
//                 //       label: 'Humidity',
//                 //       value: currentHumidityy.toString(),
//                 //     ),
//                 //     AdditionalInfoItem(
//                 //       icon: Icons.air,
//                 //       label: 'Wind Speed',
//                 //       value: currentWindSpeedd.toString(),
//                 //     ),
//                 //     AdditionalInfoItem(
//                 //       icon: Icons.beach_access,
//                 //       label: 'Pressure',
//                 //       value: currentPressuree.toString(),
//                 //     ),
//                 //   ],
//                 // ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

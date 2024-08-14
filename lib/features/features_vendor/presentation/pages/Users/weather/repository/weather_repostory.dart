import 'dart:convert';
import '../data_provider/weather_data_provider.dart';
import '../models/weather_model.dart';


class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;

  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather(String selectedItemValue) async {
    try {
      final weatherData = await weatherDataProvider.getCurrentWeather(selectedItemValue);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return WeatherModel.fromMap(data);
    } catch (e) {
        
      throw e.toString();
    }
  }
}

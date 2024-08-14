
class WeatherModel {
  final double currentTemp;
  final String currentSky;
  final dynamic currentPressure;
  final dynamic currentWindSpeed;
  final dynamic currentHumidity;
  final List<HourlyForecast> hourlyForecasts;

  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.hourlyForecasts,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];
    final hourlyForecastsData = List<Map<String, dynamic>>.from(map['list']);
    hourlyForecastsData.removeAt(0);

    final hourlyForecasts = hourlyForecastsData.map((forecastData) {
      final temp = forecastData['main']['temp'].toDouble();
      final skyCondition = forecastData['weather'][0]['main'];
      final time = DateTime.parse(forecastData['dt_txt']);
      return HourlyForecast(
        temperature: temp,
        skyCondition: skyCondition,
        time: time,
      );
    }).toList();

    return WeatherModel(
      currentTemp: currentWeatherData['main']['temp'].toDouble(),
      currentSky: currentWeatherData['weather'][0]['main'],
      currentPressure: currentWeatherData['main']['pressure'],
      currentWindSpeed: currentWeatherData['wind']['speed'],
      currentHumidity: currentWeatherData['main']['humidity'],
      hourlyForecasts: hourlyForecasts,
    );
  }

  static getWeatherModel() {}
}

class HourlyForecast {
  final double temperature;
  final String skyCondition;
  final DateTime time;

  HourlyForecast({
    required this.temperature,
    required this.skyCondition,
    required this.time,
  });
}

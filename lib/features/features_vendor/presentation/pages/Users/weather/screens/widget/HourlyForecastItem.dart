import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String temperature;
  final IconData skyCondition;
  final String time;

  const HourlyForecastItem({
    Key? key,
    required this.time,
    required this.temperature,
    required this.skyCondition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double celsiusTemperature = double.parse(temperature) - 273.15;
    String celsiusTemperatureString = celsiusTemperature.toStringAsFixed(0);
    return Card(
      elevation: 6,
      child: Container(
        width: MediaQuery.of(context).size.width / 6.9,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 7),
            Icon(
              skyCondition,
              size: 16,
            ),
            const SizedBox(height: 7),
            Text(
              ('$celsiusTemperatureString °C'),
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 80,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

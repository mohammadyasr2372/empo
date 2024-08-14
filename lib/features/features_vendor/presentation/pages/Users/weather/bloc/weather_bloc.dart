// ignore_for_file: depend_on_referenced_packages, unused_import
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../searchEmpo/searchEmpo.dart';
import '../models/weather_model.dart';
import '../repository/weather_repostory.dart';
import '../screens/weather_screen.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetched>(_getCurrentWeather);
  }
  void _getCurrentWeather(
    WeatherFetched event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getCurrentWeather(event.city);
      emit(WeatherSuccess(weatherModel: weather));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }
}

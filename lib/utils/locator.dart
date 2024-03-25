import 'package:get_it/get_it.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/api_key.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<WeatherFactory>(WeatherFactory(API_KEY));
}

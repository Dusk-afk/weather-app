import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/utils/locator.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherLoading()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      try {
        WeatherFactory wf = locator.get<WeatherFactory>();
        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );

        emit(WeatherSuccess(weather));
      } catch (e, st) {
        emit(WeatherFailure());
        debugPrint(e.toString());
        debugPrintStack(stackTrace: st);
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/blocs/weather/weather_bloc.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/utils/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: LocationService.getCurrentLocation(),
          builder: (context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Scaffold(
                  body: Center(
                    child: Text('Location permission denied'),
                  ),
                );
              }

              return BlocProvider(
                create: (context) =>
                    WeatherBloc()..add(FetchWeatherEvent(snapshot.data!)),
                child: const HomeScreen(),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}

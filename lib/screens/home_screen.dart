import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/blocs/weather/weather_bloc.dart';
import 'package:weather_app/services/location_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _circle(Colors.cyan.withOpacity(0.3), width * 1.8),
          ),
          Positioned(
            top: -100,
            left: 0,
            right: 0,
            child: _circle(
              const Color.fromARGB(255, 255, 182, 72),
              width * 1.2,
            ),
          ),
          Positioned(
            top: width * 0.3,
            left: -width * 0.6,
            right: 0,
            child: _circle(Colors.purple, width * 0.6),
          ),
          Positioned(
            top: width * 0.3,
            left: 0,
            right: -width * 0.6,
            child: _circle(Colors.purple, width * 0.6),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          ),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                );
              }

              if (state is WeatherFailure) {
                return const Center(
                  child: Text(
                    'Failed to fetch weather data',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }

              state = state as WeatherSuccess;

              return Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: kToolbarHeight + 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📍 ${state.weather.areaName}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getGreetingMessage(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child:
                          _getWeatherIcon(state.weather.weatherConditionCode!),
                    ),
                    Center(
                      child: Text(
                        '${state.weather.tempFeelsLike!.celsius!.round()} °C',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 55,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        state.weather.weatherMain!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        DateFormat('EEEE dd •')
                            .add_jm()
                            .format(state.weather.date!),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/11.png',
                              scale: 8,
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sunrise',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  DateFormat()
                                      .add_jm()
                                      .format(state.weather.sunrise!),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/12.png',
                              scale: 8,
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sunset',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  DateFormat()
                                      .add_jm()
                                      .format(state.weather.sunset!),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/13.png',
                              scale: 8,
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Temp Max',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "${state.weather.tempMax!.celsius!.round()} °C",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(children: [
                          Image.asset(
                            'assets/14.png',
                            scale: 8,
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Temp Min',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "${state.weather.tempMin!.celsius!.round()} °C",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          )
                        ])
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: kToolbarHeight + 10,
            right: 20,
            child: IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () async {
                final Position position =
                    await LocationService.getCurrentLocation();
                // ignore: use_build_context_synchronously
                context.read<WeatherBloc>().add(FetchWeatherEvent(position));
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _circle(Color color, [double? diameter]) => Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      );

  String _getGreetingMessage() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Widget _getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/5.png');
      case == 800:
        return Image.asset('assets/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/7.png');
      default:
        return Image.asset('assets/7.png');
    }
  }
}

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/network/api_service.dart';
import 'package:weather_app/network/model/models.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({@required this.api}) : super(WeatherInitial());
  final ApiService api;

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield LoadingWeatherState();
      try {
        final response = await api.getWeather(event.cityCode);
        yield LoadedWeatherState(weathersModel: response);
      } on SocketException {
        yield ErrorWeatherState();
      } on Exception {
        yield ErrorWeatherState();
      }
    }
  }
}

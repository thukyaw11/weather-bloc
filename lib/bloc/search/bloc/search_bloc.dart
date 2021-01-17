import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/network/api_service.dart';
import 'package:weather_app/network/model/models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final ApiService api;

  SearchBloc({@required this.api}) : super(CityEmptyState());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if(event is FetchCityEvent) {
      yield CityLoadingState();

      try{
        final response = await api.getCities(event.cityName);
        if(response.isEmpty) {
          yield CityNoResultState();
        } else {
          yield CityLoadedState(cityModels: response);
        }
      } on SocketException {
        yield CityErrorState(error : "Error with socket! (Internet or wifi disconnected)");
      } on Exception {
        yield CityErrorState(error: "Error with exception (Internet or wifi disconnected)");
      }
    }
  }
}

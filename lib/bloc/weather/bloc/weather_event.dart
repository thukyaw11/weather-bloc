part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();


}

class FetchWeather extends WeatherEvent {
  final int cityCode;

  FetchWeather({@required this.cityCode}):assert(cityCode != null);

  @override
  List<Object> get props => [cityCode];

}

part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

//Событие для запроса текущих данных о погоде
class WeatherRequest extends WeatherEvent {
  final String cityName;

  WeatherRequest({required this.cityName});
}

//Событие для запроса прогноза погоды
class ForecastRequest extends WeatherEvent {
  final String cityName;

  ForecastRequest({required this.cityName});
}

//Событие для перехода на главный экран (со строкой поиска)
class MainRequest extends WeatherEvent {
}
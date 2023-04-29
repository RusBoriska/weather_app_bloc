part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

//Первоначальное состояние (главное окно со строкой поиска)
class WeatherInitial extends WeatherState {}

//Состояние при загрузке текущих данных о погоде
class WeatherLoadInProgress extends WeatherState {}

//Состояние при успешной загрузке текущих данных о погоде
class WeatherLoadSuccess extends WeatherState {
  final Weather weather;

  WeatherLoadSuccess({required this.weather});
}

//Состояние при ошибке загрузки данных о погоде (как текущих, так и прогноза)
class WeatherLoadFailure extends WeatherState {
  final String error;

  WeatherLoadFailure({required this.error});
}

//Состояние при успешной загрузке прогноза погоды
class ForecastLoadSuccess extends WeatherState {
  final Forecast forecast;

  ForecastLoadSuccess({required this.forecast});
}
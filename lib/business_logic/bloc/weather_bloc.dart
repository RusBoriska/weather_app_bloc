import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '/data/models/weather.dart';
import '/data/repositories/weather_repository.dart';
import '/data/models/forecast.dart';
import '/data/repositories/forecast_repository.dart';


part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final _weatherRepository = WeatherRepository();
  final _forecastRepository = ForecastRepository();
  WeatherBloc() : super(WeatherInitial()) {
    //Запрашиваем текущие данные о погоде
  on<WeatherRequest>((event, emit) async {
    emit(WeatherLoadInProgress());
    try {
      final weatherResponse =
      await _weatherRepository.getWeather(event.cityName);
      emit(WeatherLoadSuccess(weather: weatherResponse));
    } catch (e) {
      print(e);
      emit(WeatherLoadFailure(error: e.toString()));
    }
  }
  );

  //Запрашиваем прогноз погоды
  on<ForecastRequest>((event, emit) async {
    emit(WeatherLoadInProgress());
    try {
      final forecastResponse =
      await _forecastRepository.getForecast(event.cityName);
      forecastResponse.list.sort((a, b) => a.main.temp.compareTo(b.main.temp)); //Сортируем данные в соответствии с ТЗ, чтобы в начале списка была самая низкая температура
      emit(ForecastLoadSuccess(forecast: forecastResponse));
    } catch (e) {
      print(e);
      emit(WeatherLoadFailure(error: e.toString()));
    }
  }
  );

  //Переходим на главный экран (со строкой поиска)
  on<MainRequest>((event, emit) {
    emit(WeatherInitial());
  }
  );

  }
}
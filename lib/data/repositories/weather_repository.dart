import 'dart:convert';
import 'package:http/http.dart' as http;
import '/data/data_providers/weather_data_provider.dart';
import '/data/models/weather.dart';

//Хранилище для текущих данных о погоде (в переменной weather хранятся данные, отобранные в соответствии с нашей моделью)
class WeatherRepository {
  final WeatherDataProvider weatherDataProvider = WeatherDataProvider();

  Future<Weather> getWeather(String location) async {
    final http.Response rawWeather =
        await weatherDataProvider.getRawWeatherData(location);
    final json = await jsonDecode(rawWeather.body);
    final Weather weather = Weather.fromJson(json);
    return weather;
  }
}
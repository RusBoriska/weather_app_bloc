import 'dart:convert';
import 'package:http/http.dart' as http;
import '/data/data_providers/forecast_data_provider.dart';
import '/data/models/forecast.dart';

//Хранилище для прогноза погоды (в переменной forecast хранятся данные, отобранные в соответствии с нашей моделью)
class ForecastRepository {
  final ForecastDataProvider forecastDataProvider = ForecastDataProvider();

  Future<Forecast> getForecast(String location) async {
    final http.Response rawForecast =
        await forecastDataProvider.getRawForecastData(location);
    final json = await jsonDecode(rawForecast.body);
    final Forecast forecast = Forecast.fromJson(json);
    return forecast;
  }
}
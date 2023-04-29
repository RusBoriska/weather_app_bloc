import 'package:http/http.dart' as http;

//Получаем "сырые" данные по прогнозу погоды
class ForecastDataProvider {
  final String API_KEY = "4958f12ead4a3e53fa2ee5e4f5dcdc8e";

  Future<http.Response> getRawForecastData(String city) async {
    http.Response rawForecastData = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$API_KEY&units=metric"),
    );
    // print(rawForecastData.body); // Использовалось при разработке, чтобы увидеть в консоли полученные данные
    return rawForecastData;
  }
}
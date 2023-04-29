import 'package:http/http.dart' as http;

//Получаем "сырые" данные о погоде на текущий момент
class WeatherDataProvider {
  final String API_KEY = "4958f12ead4a3e53fa2ee5e4f5dcdc8e";

  Future<http.Response> getRawWeatherData(String city) async {
    http.Response rawWeatherData = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$API_KEY&units=metric"),
    );
    // print(rawWeatherData.body); // Использовалось при разработке, чтобы увидеть в консоли полученные данные
    return rawWeatherData;
  }
}
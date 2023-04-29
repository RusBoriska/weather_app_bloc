import 'dart:convert';

//Наша модель текущих данных, в которой присутствует значительно меньше полей, чем в "сырых" даных из API, поскольку мы выбрали только то,
// что в дальнейшем будем отображать в пользовательском интерфейсе (даже если есть что-то лишнее, то это использовалось при разработке и тестировании)
Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Main main;
  Wind wind;
  String name;
  int cod;

  Weather({
    required this.main,
    required this.wind,
    required this.name,
    required this.cod,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    main: Main.fromJson(json["main"]),
    wind: Wind.fromJson(json["wind"]),
    name: json["name"],
    cod: json["cod"],
  );

  Map<String, dynamic> toJson() => {
    "main": main.toJson(),
    "wind": wind.toJson(),
    "name": name,
    "cod": cod,
  };
}

class Main {
  double temp;
  int humidity;

  Main({
    required this.temp,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: json["temp"]?.toDouble(),
    humidity: json["humidity"],
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "humidity": humidity,
  };
}

class Wind {
  double speed;

  Wind({
    required this.speed,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
  };
}
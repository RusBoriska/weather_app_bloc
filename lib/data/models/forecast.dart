import 'dart:convert';

//Наша модель прогноза погоды
Forecast forecastFromJson(String str) => Forecast.fromJson(json.decode(str));

String forecastToJson(Forecast data) => json.encode(data.toJson());

class Forecast {
  List<ListElement> list;

  Forecast({
    required this.list,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  int dt;
  Main main;
  DateTime dtTxt;

  ListElement({
    required this.dt,
    required this.main,
    required this.dtTxt,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    dt: json["dt"],
    main: Main.fromJson(json["main"]),
    dtTxt: DateTime.parse(json["dt_txt"]),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "main": main.toJson(),
    "dt_txt": dtTxt.toIso8601String(),
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

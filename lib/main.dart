import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/business_logic/bloc/weather_bloc.dart';
import 'presentation/screens/weather_app.dart';

//Запуск нашего приложения
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: MaterialApp(
        home: WeatherApp(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/business_logic/bloc/weather_bloc.dart';

//Экраны нашего приложения
class WeatherApp extends StatelessWidget {
  final _cityController = TextEditingController(); //Контроллер для строки поиска
  final String imageFromAssets = "assets/images/sun.png"; //Картинка, которая на самом деле не имеет никакой художественной ценности
  bool _myButtons = false; // Логическая переменная, в зависимости от значения которой пользователю показываются дополнительные кнопки в AppBar

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              title: Text("Погода в доме"),
              centerTitle: true,
              actions: _myButtons ?
              [
                IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'Открыть главную страницу',
                  onPressed: () {
                    _cityController.text = "";
                    context.read<WeatherBloc>().add( //Переход на главный экран (со строкой поиска)
                      MainRequest(),
                    );
                    _myButtons = false; //Устанавливаем значение на false, чтобы дополнительные кнопки исчезли из AppBar
                    // print('_myButtons is $_myButtons'); //Использовалось при разработке
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.list),
                  tooltip: 'Прогноз погоды',
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      context.read<WeatherBloc>().add( //Переход на экран с прогнозом погоды
                        ForecastRequest(
                          cityName: _cityController.text,
                        ),
                      );
                    }
                    _myButtons = false;
                    // print('_myButtons is $_myButtons'); //Использовалось при разработке
                  },
                ),
              ]
                  :
              null
          ),
          body: BlocConsumer<WeatherBloc, WeatherState>(
            listener: (context, state) {
              if (state is WeatherLoadInProgress) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Загрузка данных"), //Здесь и далее текст SnackBar позволяет увидеть, что происходит на экране (даже если некоторых SnackBar не было в ТЗ)
                  ),
                );
              }
              if (state is WeatherLoadSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Успешная загрузка данных"),
                  ),
                );
                _myButtons = true;
                // print('_myButtons is $_myButtons'); //Использовалось при разработке
              }
              if (state is ForecastLoadSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Прогноз погоды получен"),
                  ),
                );
              }
              if (state is WeatherLoadFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(bottom: 500.0),
                    content: Text("Ошибка: ${state.error}"),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is WeatherLoadInProgress)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (state is WeatherLoadFailure)
                return Center(
                        child: Text("Ошибка получения данных"),
                );
              else if (state is WeatherInitial)
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        imageFromAssets,
                        height: 200,
                        width: 200,
                      ),
                      TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          hintText: "Введите название города",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_cityController.text.isNotEmpty) {
                                context.read<WeatherBloc>().add(
                                  WeatherRequest(
                                    cityName: _cityController.text, //Вводим название города, чтобы получить данные о погоде
                                  ),
                                );
                              }
                            },
                            child: Text("Подтвердить"),
                          ),

                          SizedBox(
                            height: 200,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              else if (state is WeatherLoadSuccess) //Состояние, при котором на экране появляются данные о погоде
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            imageFromAssets,
                            height: 200,
                            width: 200,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            state.weather.name, //Название города
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayMedium,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Температура: ${state.weather.main.temp} С"),
                          Text("Влажность: ${state.weather.main.humidity} %"),
                          Text("Скорость ветра: ${state.weather.wind.speed} м/с"),
                        ],
                      ),
                    ],
                  ),
                );

              else if (state is ForecastLoadSuccess) //Состояние, при котором на экране появляется прогноз погоды
                return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    // itemCount: state.forecast.list.length, //По умолчанию API даёт прогноз погоды на 5 дней через каждые 3 часа (5*(24/3)=40)
                    itemCount: 24, //Это прогноз погоды на 3 дня через каждые 3 часа (3*(24/3)=24)
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text("${state.forecast.list[index].main.temp}", //Температура
                              style: TextStyle(fontSize: 22)),
                          subtitle: Text("${state.forecast.list[index].dtTxt}") //Дата и время
                      );
                    }
                );
              else
                return Container();
            },
          ),
        );
      },
    );
  }
}
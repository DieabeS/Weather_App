import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_quiz_app/bloc/weather_bloc.dart';
import 'package:weather_quiz_app/managers/shared_prefernces_manager.dart';
import 'package:weather_quiz_app/models/weather_response/weather_response.dart';
import 'package:weather_quiz_app/ui/screens/weather_details_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextStyle textStyle() => const TextStyle(fontSize: 18, color: Colors.white);
  @override
  void initState() {
    super.initState();
    WeatherBloc.instance.init();
    var date = SharedPreferencesManager.instance.sharedPreferences.getString('date');
    var data = SharedPreferencesManager.instance.sharedPreferences.getString('weatherResponse');

    if (DateFormat().add_yMMMMEEEEd().format(DateTime.parse(DateTime.now().toString())) != date) {
      WeatherBloc.instance.getWeather(appid: '8925480114759bf525fdade7a857b52c', id: '292223', fromApi: true);
    } else {
      WeatherResponse weatherResponse = WeatherResponse.fromJson(jsonDecode(data.toString()));
      WeatherBloc.instance.getWeather(fromApi: false, weatherResponse: weatherResponse);
    }
  }

  @override
  void dispose() {
    super.dispose();
    WeatherBloc.instance.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Forecast Report',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<WeatherResponse>(
          stream: WeatherBloc.instance.weatherResponse,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/weather.jpg',
                        ),
                        fit: BoxFit.cover),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                      child: Text(
                    snapshot.error.toString(),
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  )));
            } else if (snapshot.hasData) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/weather.jpg',
                      ),
                      fit: BoxFit.cover),
                ),
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                  itemCount: WeatherBloc.instance.dateList!.value.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.transparent,
                      elevation: 1,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeatherDetailsScreen(
                                dayWeather: WeatherBloc.instance
                                    .getDayWeather(WeatherBloc.instance.tempList!.value[index].dtTxt),
                                date: '${WeatherBloc.instance.dateList!.value[index]}',
                              ),
                            ),
                          );
                        },
                        title: Center(
                          child: WeatherBloc.instance.dateList!.hasValue == true
                              ? Hero(
                                  tag: 'date-${WeatherBloc.instance.dateList!.value[index]}',
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text('${WeatherBloc.instance.dateList!.value[index]}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white)),
                                  ),
                                )
                              : const Text(''),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            snapshot.data != null
                                ? Text(
                                    '${(WeatherBloc.instance.tempList!.value[index].main.temp - 273.15).round().toString()}\u2103 ',
                                    style: textStyle())
                                : const Text(''),
                            snapshot.data != null
                                ? Text(WeatherBloc.instance.tempList!.value[index].weather[0].main, style: textStyle())
                                : const Text('')
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/weather.jpg',
                        ),
                        fit: BoxFit.cover),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )));
            }
          }),
    );
  }
}

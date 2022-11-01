
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/models/base_response/base_response.dart';
import 'package:weather_app/models/weather_object/weather_object.dart';
import 'package:weather_app/models/weather_response/weather_response.dart';
import 'package:weather_app/resources/repository.dart';

import 'base_bloc.dart';

class WeatherBloc extends BaseBloc {
  static WeatherBloc? _instance;
  static WeatherBloc get instance {
    _instance ??= WeatherBloc();
    return _instance!;
  }

  BehaviorSubject<WeatherResponse?>? _weatherResponse;

  BehaviorSubject<List>? _dateList;
  BehaviorSubject<List>? _tempList;

  ValueStream<WeatherResponse?>? get weatherResponse => _weatherResponse?.stream;
  ValueStream<List>? get dateList => _dateList?.stream;
  ValueStream<List>? get tempList => _tempList?.stream;

  @override
  void init() {
    _weatherResponse = BehaviorSubject<WeatherResponse?>();
    _dateList = BehaviorSubject<List>();
    _tempList = BehaviorSubject<List>();
  }

  @override
  void dispose() {
    _weatherResponse?.close();
    _dateList?.close();
    _instance!.dispose();
  }

  Future<String?> getWeather(
      {String? appid, String? city, required bool fromApi, WeatherResponse? weatherResponse}) async {
    if (fromApi) {
        _weatherResponse?.sink.add(null);

      BaseResponse<WeatherResponse> response;
      var dates = [];
      var temps = [];

      response = await Repository.instance.getWeather(appid: appid!, city: city!);
      if (response.isSucceed) {
        _weatherResponse?.sink.add(response.data!);

        for (int i = 0; i < response.data!.list.length; i++) {
          if (!dates.contains(DateFormat().add_yMMMMEEEEd().format(DateTime.parse(response.data!.list[i].dtTxt)))) {
            dates.add(DateFormat().add_yMMMMEEEEd().format(DateTime.parse(response.data!.list[i].dtTxt)));
            temps.add(response.data!.list[i]);
          }
        }
        _dateList!.sink.add(dates);
        _tempList!.sink.add(temps);

        
      } else {
        _weatherResponse?.sink.addError(response.error!);
      }
    } else {
      WeatherResponse? response = weatherResponse;
      var dates = [];
      var temps = [];

      _weatherResponse?.sink.add(response!);

      for (int i = 0; i < response!.list.length; i++) {
        if (!dates.contains(DateFormat().add_yMMMMEEEEd().format(DateTime.parse(response.list[i].dtTxt)))) {
          dates.add(DateFormat().add_yMMMMEEEEd().format(DateTime.parse(response.list[i].dtTxt)));
          temps.add(response.list[i]);
        }
      }
      _dateList!.sink.add(dates);
      _tempList!.sink.add(temps);
    }
  }

  List<WeatherObject> getDayWeather(String date) {
    DateTime selectedDay = DateTime.parse(date);
    List<WeatherObject> dayWeather = [];
    for (int i = 0; i < weatherResponse!.value!.list.length; i++) {
      DateTime tempDate = DateTime.parse(weatherResponse!.value!.list[i].dtTxt);

      if (tempDate.year == selectedDay.year && tempDate.month == selectedDay.month && tempDate.day == selectedDay.day) {
        dayWeather.add(weatherResponse!.value!.list[i]);
      }
    }
    return dayWeather;
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/models/main_weather/main_weather.dart';
import 'package:weather_app/models/weather_status/weather_status.dart';
import 'package:weather_app/models/wind/wind.dart';
part 'weather_object.g.dart';

@JsonSerializable()
class WeatherObject {
  MainWeather main;
  Wind wind;
  @JsonKey(name: 'dt_txt')
  String dtTxt;
  List<WeatherStatus> weather;

  WeatherObject({required this.main, required this.dtTxt, required this.wind, required this.weather});

  factory WeatherObject.fromJson(Map<String, dynamic> json) => _$WeatherObjectFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherObjectToJson(this);
}

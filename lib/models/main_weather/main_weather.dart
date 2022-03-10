import 'package:json_annotation/json_annotation.dart';
part 'main_weather.g.dart';

@JsonSerializable()
class MainWeather {
  double temp;
  double humidity;

  MainWeather({required this.temp, required this.humidity});

  factory MainWeather.fromJson(Map<String, dynamic> json) => _$MainWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$MainWeatherToJson(this);
}

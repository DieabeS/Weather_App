import 'package:json_annotation/json_annotation.dart';
import 'package:weather_quiz_app/models/city/city.dart';
import 'package:weather_quiz_app/models/weather_object/weather_object.dart';
part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  String cod;
  City city;
  List<WeatherObject> list;

  WeatherResponse({required this.cod, required this.city, required this.list});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

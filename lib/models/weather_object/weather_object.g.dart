// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherObject _$WeatherObjectFromJson(Map<String, dynamic> json) =>
    WeatherObject(
      main: MainWeather.fromJson(json['main'] as Map<String, dynamic>),
      dtTxt: json['dt_txt'] as String,
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherObjectToJson(WeatherObject instance) =>
    <String, dynamic>{
      'main': instance.main,
      'wind': instance.wind,
      'dt_txt': instance.dtTxt,
      'weather': instance.weather,
    };

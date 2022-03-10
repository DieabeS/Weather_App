import 'package:json_annotation/json_annotation.dart';
part 'weather_status.g.dart';

@JsonSerializable()
class WeatherStatus {
  String main;

  WeatherStatus({required this.main});
  factory WeatherStatus.fromJson(Map<String, dynamic> json) => _$WeatherStatusFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStatusToJson(this);
}

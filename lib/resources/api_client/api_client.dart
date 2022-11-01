import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:weather_app/models/weather_response/weather_response.dart';
part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  @GET("/forecast")
  Future<WeatherResponse> getWeather({@Query('q') required String city, @Query('appid') required String appid});
}

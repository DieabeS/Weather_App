import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:weather_quiz_app/models/weather_response/weather_response.dart';
part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  @GET("/forecast")
  Future<WeatherResponse> getWeather({@Query('id') required String id, @Query('appid') required String appid});
}

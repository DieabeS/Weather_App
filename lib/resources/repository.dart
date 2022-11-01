import 'package:weather_app/models/base_response/base_response.dart';
import 'package:weather_app/models/weather_response/weather_response.dart';

import 'api_client/api_client.dart';
import 'base_repository.dart';

class Repository extends BaseRepository {
  static Repository? _instance;
  ApiClient? _apiClient;

  Repository._internal() {
    _apiClient = ApiClient(getDioInstance(), baseUrl: 'https://api.openweathermap.org/data/2.5');
  }

  static Repository get instance {
    _instance ??= Repository._internal();
    return _instance!;
  }

  static void resetInstance() {
    _instance = Repository._internal();
  }

  Future<BaseResponse<WeatherResponse>> getWeather({required String city, required String appid}) async {
    return await _apiClient!
        .getWeather(city: city, appid: appid)
        .then((value) => BaseResponse<WeatherResponse>(data: value, isSucceed: true))
        .catchError((e) => BaseResponse<WeatherResponse>(isSucceed: false, error: 'Something Went Wrong', data: null));
  }
}

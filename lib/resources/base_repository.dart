import 'package:dio/dio.dart';
import 'package:weather_quiz_app/models/base_response/base_response.dart';

abstract class BaseRepository {
  Future<BaseResponse<T>> catchError<T>(e) async {
    var message = '';

    if (e is DioError) {
      if (e.type == DioErrorType.connectTimeout) {
        message = "no internet";
      } else if (e.response?.data != null) {
        message = e.response!.data;
      } else if (e.response?.statusMessage != null) {
        message = e.response!.statusMessage!;
      }

      if (e.error is String) {
        if (message.isEmpty) {
          message = e.error;
        }
      }

      if (message.isEmpty) {
        message = e.message;
      }
    }

    if (message.isEmpty) {
      message = "Something Went Wrong";
    }

    return BaseResponse<T>(error: message, isSucceed: false);
  }

  Dio getDioInstance() {
    var dio = Dio();
    dio.options.contentType = 'application/json';

    return dio;
  }
}

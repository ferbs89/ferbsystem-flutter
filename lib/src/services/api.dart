import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Dio dio = new Dio();

  Api() {
    dio.options.baseUrl = "https://ferbs89.herokuapp.com/api";

    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');

        if (token != null)
          options.headers["Authorization"] = "Bearer " + token;

        return options;
      },

      onResponse:(Response response) async {
        print('api response');

        return response;
      },

      onError: (DioError e) async {
        print('api error');

        return e;
      }
    ));
  }
}
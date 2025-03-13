import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/utils/shared_prefrences_helper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class DioHelper {
  static const String baseUrl = "https://ecommerce.routemisr.com";

  static Dio initDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
        baseUrl: baseUrl,
      // connectTimeout: Duration(seconds: 3),
      // receiveTimeout: Duration(seconds: 3)
    );

    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: true,
    ));

    return dio;
  }
}

class AuthInterceptor extends Interceptor {
  SharedPreferencesHelper prefs = SharedPreferencesHelper();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = {
      //"Authorization":"Bearer Token ${}"
      "token": await prefs.getToken()
    };
    super.onRequest(options, handler);
  }
}

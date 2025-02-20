import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class DioHelper {
  static const String baseUrl = "https://ecommerce.routemisr.com";

  static Dio initDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 3),
        receiveTimeout: Duration(seconds: 3));

    //dio.interceptors.add(CustomLoggingInterceptor());
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

class CustomLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("Request(${options.method}): ${options.path}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "Response(${response.statusCode}): ${response.realUri.path} -> Data: ${response.data}");
    super.onResponse(response, handler);
  }
}

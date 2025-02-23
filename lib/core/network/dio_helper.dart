import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class DioHelper {
  static const baseUrl = "https://ecommerce.routemisr.com";

  static Dio initDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 3),
      receiveTimeout: Duration(seconds: 3),
    );
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
    ));
    return dio;
  }
}
// class CustomInterceptor extends Interceptor{
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     print("Request(${options.method}) => ${options.path}: body: ${options.data}");
//     super.onRequest(options, handler);
//   }
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     print("Request(${options.method}) => ${options.path}: body: ${options.data}");
//     super.onResponse(response, handler);
//   }
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     // TODO: implement onError
//     super.onError(err, handler);
//   }
// }

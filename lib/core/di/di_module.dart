import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/dio_helper.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DiModule {
  @singleton
  Dio initDio() => DioHelper.initDio();

  @singleton
  Connectivity getConnectivity() => Connectivity();
}

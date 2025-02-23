import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/dio_helper.dart';
import 'package:injectable/injectable.dart';

///For 3rd party packages
@module
abstract class DiModule {
  @singleton
  Dio getDio() => DioHelper.initDio();

  Connectivity getConnectivity() => Connectivity();
}

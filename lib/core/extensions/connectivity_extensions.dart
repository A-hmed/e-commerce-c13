import 'package:connectivity_plus/connectivity_plus.dart';

extension ConnectivityExtensions on Connectivity {
  Future<bool> get isConnected async {
    List<ConnectivityResult> list = await checkConnectivity();
    return list.contains(ConnectivityResult.wifi) ||
        list.contains(ConnectivityResult.mobile);
  }
}

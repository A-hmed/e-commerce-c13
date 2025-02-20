import 'package:connectivity_plus/connectivity_plus.dart';

extension ConnectivityExtension on Connectivity {
  Future<bool> get isConnected async {
    List<ConnectivityResult> results = await checkConnectivity();
    return results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.wifi);
  }
}

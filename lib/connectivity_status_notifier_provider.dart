import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_status_notifier_provider.g.dart';

enum ConnectivityStatus { notDetermined, isConnected, isDisonnected }

@Riverpod(keepAlive: true)
class ConnectivityStatusNotifier extends _$ConnectivityStatusNotifier {
  @override
  ConnectivityStatus build() {
    updateConnection();
    return ConnectivityStatus.isConnected;
  }

  void updateConnection() async {
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.bluetooth:
          case ConnectivityResult.ethernet:
          case ConnectivityResult.vpn:
          case ConnectivityResult.other:
          case ConnectivityResult.mobile:
          case ConnectivityResult.wifi:
            state = ConnectivityStatus.isConnected;
            break;
          case ConnectivityResult.none:
            state = ConnectivityStatus.isDisonnected;
            break;
        }
      },
    );
  }
}

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;
  late final StreamSubscription _streamSubscription;

  NetworkCubit({required Connectivity connectivity})
      : _connectivity = connectivity,
        super(NetworkState.initial()) {
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult status) {
      if (status == ConnectivityResult.mobile ||
          status == ConnectivityResult.wifi) {
        emit(const NetworkState(connection: ConnectionType.online));
      } else if (status == ConnectivityResult.none) {
        emit(const NetworkState(connection: ConnectionType.offline));
      } else {
        emit(const NetworkState(connection: ConnectionType.unknown));
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}

part of 'network_cubit.dart';

class NetworkState {
  final ConnectionType connection;

  const NetworkState({required this.connection});

  factory NetworkState.initial() => const NetworkState(
        connection: ConnectionType.unknown,
      );

  NetworkState copyWith(ConnectionType? connection) =>
      NetworkState(connection: connection ?? this.connection);
}

enum ConnectionType {
  online,
  offline,
  unknown,
}

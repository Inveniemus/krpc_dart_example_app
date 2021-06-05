part of 'connection_bloc.dart';

abstract class KrpcConnectionState extends Equatable {
  const KrpcConnectionState();
}

class DisconnectedState extends KrpcConnectionState {
  @override
  List<Object> get props => [];
}

class ConnectedState extends KrpcConnectionState {
  final KrpcClient client;
  const ConnectedState(this.client);
  @override
  List<Object> get props => [client];
}

class ConnectingState extends KrpcConnectionState {
  @override
  List<Object> get props => [];
}

class ConnectionErrorState extends KrpcConnectionState {
  final String message;
  const ConnectionErrorState({this.message = 'Unknown connection error'});
  @override
  List<Object> get props => [message];
}

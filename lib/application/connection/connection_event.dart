part of 'connection_bloc.dart';

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();
}

class GetConnectionStatus extends ConnectionEvent {
  @override
  List<Object?> get props => [];
}

class RequestConnectionEvent extends ConnectionEvent {
  final String ipAddress;
  final int rpcPort;
  final int streamPort;
  final String clientName;

  const RequestConnectionEvent(
      {this.ipAddress = 'localhost',
      this.rpcPort = 50000,
      this.streamPort = 50001,
      this.clientName = 'KrApp'});

  @override
  List<Object?> get props => [ipAddress, rpcPort, streamPort, clientName];
}

class RequestDisconnectionEvent extends ConnectionEvent {
  const RequestDisconnectionEvent();
  @override
  List<Object?> get props => [];
}

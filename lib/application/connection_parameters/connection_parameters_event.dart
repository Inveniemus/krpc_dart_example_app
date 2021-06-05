part of 'connection_parameters_bloc.dart';

abstract class ConnectionParametersEvent extends Equatable {
  const ConnectionParametersEvent();
}

class GetConnectionParametersEvent extends ConnectionParametersEvent {
  @override
  List<Object?> get props => [];
}

class IpAddressEvent extends ConnectionParametersEvent {
  final String ipAddress;

  IpAddressEvent(this.ipAddress);

  @override
  List<Object?> get props => [ipAddress];
}

class RpcPortEvent extends ConnectionParametersEvent {
  final String rpcPort;

  RpcPortEvent(this.rpcPort);

  @override
  List<Object?> get props => [rpcPort];
}

class StreamPortEvent extends ConnectionParametersEvent {
  final String streamPort;

  StreamPortEvent(this.streamPort);

  @override
  List<Object?> get props => [streamPort];
}

class ClientNameEvent extends ConnectionParametersEvent {
  final String clientName;
  ClientNameEvent(this.clientName);
  @override
  List<Object?> get props => [clientName];
}
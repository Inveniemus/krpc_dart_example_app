part of 'connection_parameters_bloc.dart';

abstract class ConnectionParametersState extends Equatable {
  const ConnectionParametersState();
}

class ConnectionParametersInitial extends ConnectionParametersState {
  @override
  List<Object> get props => [];
}

class ConnectionParametersOK extends ConnectionParametersState {
  final KrpcConnectionParameters parameters;

  ConnectionParametersOK(this.parameters);

  @override
  List<Object> get props => [parameters];
}

class ConnectionParametersError extends ConnectionParametersState {
  final String? ipError;
  final String? rpcPortError;
  final String? streamPortError;
  final String? clientNameError;

  ConnectionParametersError(
      {this.ipError,
      this.rpcPortError,
      this.streamPortError,
      this.clientNameError});

  @override
  List<Object> get props => [
        ipError ?? 'null',
        rpcPortError ?? 'null',
        streamPortError ?? 'null',
        clientNameError ?? 'null'
      ];
}

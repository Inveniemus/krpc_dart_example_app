import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'connection_parameters_event.dart';

part 'connection_parameters_state.dart';

class KrpcConnectionParameters {
  String ipAddress = 'localhost';
  int rpcPort = 50000;
  int streamPort = 50001;
  String clientName = 'KrApp';

  bool get ipValid {
    if (ipAddress.toLowerCase() == 'localhost') {
      ipAddress = 'localhost';
      return true;
    }

    final regExp = RegExp(
        r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    if (regExp.hasMatch(ipAddress)) {
      ipAddress = regExp.firstMatch(ipAddress)!.group(0)!;
      return true;
    }

    return false;
  }

  bool get rpcValid {
    if (rpcPort <= 65535 && rpcPort > 0) return true;
    return false;
  }

  bool get streamValid {
    if (streamPort <= 65535 && streamPort > 0) return true;
    return false;
  }

  bool get clientNameValid {
    if (clientName == '')
      return false; // Just in case kRPC would accept it, we wouldn't.
    return true;
  }

  bool get valid => ipValid && rpcValid && streamValid && clientNameValid;
}

class ConnectionParametersBloc
    extends Bloc<ConnectionParametersEvent, ConnectionParametersState> {
  final KrpcConnectionParameters _parameters = KrpcConnectionParameters();

  ConnectionParametersBloc() : super(ConnectionParametersInitial());

  @override
  Stream<ConnectionParametersState> mapEventToState(
    ConnectionParametersEvent event,
  ) async* {
    if (event is GetConnectionParametersEvent) {

    } else if (event is IpAddressEvent) {
      _parameters.ipAddress = event.ipAddress;
    } else if (event is RpcPortEvent) {
      _parameters.rpcPort = int.tryParse(event.rpcPort) ?? -1;
    } else if (event is StreamPortEvent) {
      _parameters.streamPort = int.tryParse(event.streamPort) ?? -1;
    } else if (event is ClientNameEvent) {
      _parameters.clientName = event.clientName;
    }
    yield _getState();
  }

  ConnectionParametersState _getState() {
    if (_parameters.valid) {
      return ConnectionParametersOK(_parameters);
    } else {
      return ConnectionParametersError(
        ipError: _getIpError(),
        rpcPortError: _getRpcPortError(),
        streamPortError: _getStreamPortError(),
        clientNameError: _getClientNameError(),
      );
    }
  }

  String? _getIpError() {
    if (!_parameters.ipValid) return '"localhost" or "xxx.xxx.xxx.xxx"';
  }

  String? _getRpcPortError() {
    if (!_parameters.rpcValid) return 'Wrong RPC port number';
  }

  String? _getStreamPortError() {
    if (!_parameters.streamValid) return 'Wrong stream port number';
  }

  String? _getClientNameError() {
    if (!_parameters.clientNameValid) return 'Client name cannot be empty';
  }
}

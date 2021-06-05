import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krpc_dart/krpc_dart.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, KrpcConnectionState> {
  ConnectionBloc() : super(DisconnectedState());

  KrpcClient client = KrpcClient();

  @override
  Stream<KrpcConnectionState> mapEventToState(
    ConnectionEvent event,
  ) async* {
    if (event is RequestConnectionEvent) {
      yield ConnectingState();

      client = KrpcClient(
        ip: event.ipAddress,
        rpcPort: event.rpcPort,
        streamPort: event.streamPort,
        clientName: event.clientName,
      );

      try {
        await client.connectRPC();
        yield ConnectedState(client);
      } on KrpcConnectionError catch (error) {
        yield ConnectionErrorState(message: error.message);
      }
    } else if (event is RequestDisconnectionEvent) {
      try {
        await client.disconnect();
      } on Exception {
        print('Exception on client disconnection');
        client = KrpcClient(); // reset the client
      }
      yield DisconnectedState();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/version_expanded_row.dart';
import '../application/connection/connection_bloc.dart';
import '../application/connection_parameters/connection_parameters_bloc.dart';

class ServerStatusPage extends StatelessWidget {
  void _connect(BuildContext context) {
    BlocProvider.of<ConnectionBloc>(context)
        .add(RequestConnectionEvent(ipAddress: '192.168.0.150'));
  }

  void _disconnect(BuildContext context) {
    BlocProvider.of<ConnectionBloc>(context).add(RequestDisconnectionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kRPC Server Connection'),
      ),
      body: Center(
        child: BlocBuilder<ConnectionBloc, KrpcConnectionState>(
          builder: (context, state) {
            String stateText = 'Disconnected';
            String buttonText = 'Connect?';
            VoidCallback onPress = () => _connect(context);
            Color buttonColor = Colors.green;

            if (state is ConnectionErrorState) {
              stateText = state.message;
              buttonText = 'Try again?';
              buttonColor = Colors.amber;
              onPress = () => _connect(context);
            } else if (state is ConnectingState) {
              stateText = 'Connecting...';
              buttonText = 'Please wait...';
              buttonColor = Colors.grey;
              onPress = () => null;
            } else if (state is DisconnectedState) {
              stateText = 'Disconnected';
              buttonText = 'Connect?';
              buttonColor = Colors.green;
              onPress = () => _connect(context);
            } else if (state is ConnectedState) {
              stateText = 'Connected!';
              buttonText = 'Disconnect?';
              buttonColor = Colors.green;
              onPress = () => _disconnect(context);
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'kRPC Server Connection Parameters',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  IpTextField(),
                  RpcPortTextField(),
                  StreamPortTextField(),
                  ClientNameTextField(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: OutlinedButton(
                        onPressed: onPress,
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(buttonColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            buttonText,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        )),
                  ),
                  Text(
                    'Status: $stateText',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  VersionExpandedRow(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

abstract class _DecoratedTextField extends StatelessWidget {
  static const _decoration = InputDecoration(border: OutlineInputBorder());

  final TextEditingController _controller = TextEditingController();

  String? _getError(ConnectionParametersError state);

  void _onChanged(String value, BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionParametersBloc, ConnectionParametersState>(
        builder: (context, state) {
      InputDecoration decoration;
      if (state is ConnectionParametersError) {
        final error = _getError(state);
        decoration = _decoration.copyWith(errorText: error);
      } else {
        decoration = _decoration;
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: decoration,
          controller: _controller,
          onChanged: (value) => _onChanged(value, context),
        ),
      );
    });
  }
}

class IpTextField extends _DecoratedTextField {
  IpTextField() {
    super._controller.text = 'localhost';
  }

  @override
  String? _getError(ConnectionParametersError state) {
    return state.ipError;
  }

  @override
  void _onChanged(String value, BuildContext context) {
    BlocProvider.of<ConnectionParametersBloc>(context)
        .add(IpAddressEvent(value));
  }
}

class RpcPortTextField extends _DecoratedTextField {
  RpcPortTextField() {
    super._controller.text = '50000';
  }

  @override
  String? _getError(ConnectionParametersError state) {
    return state.rpcPortError;
  }

  @override
  void _onChanged(String value, BuildContext context) {
    BlocProvider.of<ConnectionParametersBloc>(context)
        .add(RpcPortEvent(value));
  }
}

class StreamPortTextField extends _DecoratedTextField {
  StreamPortTextField() {
    super._controller.text = '50001';
  }

  @override
  String? _getError(ConnectionParametersError state) {
    return state.streamPortError;
  }

  @override
  void _onChanged(String value, BuildContext context) {
    BlocProvider.of<ConnectionParametersBloc>(context)
        .add(StreamPortEvent(value));
  }
}

class ClientNameTextField extends _DecoratedTextField {
  ClientNameTextField() {
    super._controller.text = 'KrApp';
  }

  @override
  String? _getError(ConnectionParametersError state) {
    return state.clientNameError;
  }

  @override
  void _onChanged(String value, BuildContext context) {
    BlocProvider.of<ConnectionParametersBloc>(context)
        .add(ClientNameEvent(value));
  }
}

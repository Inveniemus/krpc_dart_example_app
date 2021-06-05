import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/version_expanded_row.dart';
import '../application/connection_bloc.dart';

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
                    'kRPC Server Status',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: OutlinedButton(
                        onPressed: onPress,
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(buttonColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            buttonText,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        )),
                  ),
                  Text(
                    stateText,
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
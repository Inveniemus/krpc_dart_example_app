import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krpc_dart/krpc_dart.dart';
import '../application/connection/connection_bloc.dart';

class VersionExpandedRow extends StatelessWidget {

  Future<String> _getVersion(KrpcClient client) async {
    try {
      final krpcService = KRPC(client);
      final status = await krpcService.getStatus();
      return status.version;
    } on KrpcConnectionError catch (error) {
      return 'Error: $error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('kRPC version:', textAlign: TextAlign.right,),
        )),
        BlocBuilder<ConnectionBloc, KrpcConnectionState>(
          builder: (context, state) {
            if (state is ConnectedState) {
              return FutureBuilder(
                future: _getVersion(state.client),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else {
                    return Text('?');
                  }
                },
              );
            }
            return Text('?');
          },
        ),
      ],
    );
  }
}

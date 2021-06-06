import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krpc_dart/krpc_dart.dart';
import 'package:krpc_dart_example_app/application/connection/connection_bloc.dart';
import '../widgets/sas_rcs_buttons_row.dart';

class SASRCSControlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vessel Control'),
      ),
      body: Column(
        children: [
          ActiveVesselStatus(),
          SASRCSButtonsRow(),
        ],
      ),
    );
  }
}

class ActiveVesselStatus extends StatelessWidget {
  Future<String> _getActiveVesselName(KrpcClient krpcClient) async {
    final spaceCenter = SpaceCenter(krpcClient);
    try {
      final vessel = await spaceCenter.activeVessel;
      return await vessel.name;
    } on Exception catch (exception) {
      return Future.error('Error getting Vessel: $exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<ConnectionBloc>().add(GetConnectionStatus());
    });

    return BlocBuilder<ConnectionBloc, KrpcConnectionState>(
      builder: (context, state) {
        KrpcClient? client;
        if (state is ConnectedState) {
          client = state.client;
          return FutureBuilder(
            future: _getActiveVesselName(client),
            builder: (context, snapshot) {
              String textButton = '?';
              if (snapshot.hasData) textButton = 'Vessel: ${snapshot.data}';
              if (snapshot.hasError) textButton = 'Vessel: NONE!';
              return OutlinedButton(
                onPressed: () =>
                    context.read<ConnectionBloc>().add(GetConnectionStatus()),
                child: Text(textButton),
              );
            },
          );
        }
        return OutlinedButton(
            onPressed: () => null, child: Text('NO CONNECTION'));
      },
    );
  }
}

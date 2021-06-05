import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krpc_dart_example_app/application/connection_parameters/connection_parameters_bloc.dart';

import 'route_generator.dart';
import 'application/connection/connection_bloc.dart';

void main() {
  runApp(KrApp());
}

class KrApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectionBloc>(create: (context) => ConnectionBloc(),),
        BlocProvider<ConnectionParametersBloc>(create: (context) => ConnectionParametersBloc(),),
      ],
      child: MaterialApp(
        title: 'KrApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

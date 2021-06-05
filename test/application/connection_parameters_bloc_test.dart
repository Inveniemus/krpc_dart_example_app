import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:krpc_dart_example_app/application/connection_parameters/connection_parameters_bloc.dart';

void main() {
  blocTest(
    'Default connection parameters state shall be OK',
    build: () => ConnectionParametersBloc(),
    act: (ConnectionParametersBloc bloc) => bloc..add(GetConnectionParametersEvent()),
    expect: () => [
      isA<ConnectionParametersOK>(),
    ],
  );
}

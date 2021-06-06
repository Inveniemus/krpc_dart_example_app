import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:krpc_dart_example_app/application/connection_parameters/connection_parameters_bloc.dart';

class ConnectionParametersMatcher extends CustomMatcher {
  ConnectionParametersMatcher(matcher) : super('Matcher for connection parameters', 'parameters', matcher);
  @override
  Object? featureValueOf(actual) => (actual as ConnectionParametersOK).parameters;
}

void main() {

  blocTest(
    'Default connection parameters state shall be OK',
    build: () => ConnectionParametersBloc(),
    act: (ConnectionParametersBloc bloc) => bloc..add(GetConnectionParametersEvent()),
    expect: () => [
      allOf(
        isA<ConnectionParametersOK>(),
      )
    ],
  );
}

import 'package:flutter_test/flutter_test.dart';
import 'package:krpc_dart_example_app/application/connection_parameters/connection_parameters_bloc.dart';

void main() {
  test('Default KrpcConnectionParamters shall be valid', () {
    final defaultParameters = KrpcConnectionParameters();
    expect(defaultParameters.valid, true);
  });

  test('Correct IP address shall be valid', () {
    final parameters = KrpcConnectionParameters()
        ..ipAddress = '1.1.1.1';
    expect(parameters.valid, true);
  });

  test('Correct IP address shall be valid', () {
    final parameters = KrpcConnectionParameters()
      ..ipAddress = '255.255.255.255';
    expect(parameters.valid, true);
  });

  test('Correct IP address shall be valid', () {
    final parameters = KrpcConnectionParameters()
      ..ipAddress = '192.168.0.1';
    expect(parameters.valid, true);
  });

  test('Correct IP address shall be valid', () {
    final parameters = KrpcConnectionParameters()
      ..ipAddress = '255.255.255.256';
    expect(parameters.valid, false);
  });

  test('Correct rpc port, stream port shall be valid', () {
    final parameters = KrpcConnectionParameters()
        ..rpcPort = 1
        ..streamPort = 65535;
    expect(parameters.valid, true);
  });

  test('Empty client name shall be invalid', () {
    final parameters = KrpcConnectionParameters()
        ..clientName = '';
    expect(parameters.valid, false);
  });

  test('Incorrect IP tests', () {
    final parameters = KrpcConnectionParameters()
        ..ipAddress = 'test';
    expect(parameters.valid, false);
  });
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krpc_dart_example_app/pages/krapp_home_page.dart';
import 'package:krpc_dart_example_app/pages/sas_rcs_control_page.dart';
import 'package:krpc_dart_example_app/pages/server_status_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => KrappHomePage());
      case '/server_status':
        return MaterialPageRoute(builder: (_) => ServerStatusPage());
      case '/sas_rcs_control':
        return MaterialPageRoute(builder: (_) => SASRCSControlPage());
      default:
        return MaterialPageRoute(builder: (_) => KrappHomePage());
    }
  }
}
import 'package:flutter/material.dart';

class KrappHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KrApp Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NavigationButton('Connection', '/server_status'),
            NavigationButton('Vessel Control', '/sas_rcs_control'),
          ],
        ),
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final String buttonText;
  final String route;

  NavigationButton(this.buttonText, this.route);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => Navigator.of(context).pushNamed(route),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(buttonText),
        ));
  }
}

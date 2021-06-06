import 'package:flutter/material.dart';

class SASRCSButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _SASRCSButton('SAS'),
          _SASRCSButton('RCS'),
        ],
      ),
    );
  }
}

class _SASRCSButton extends StatelessWidget {

  final String _text;
  _SASRCSButton(this._text);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: () => null, child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(_text, style: Theme.of(context).textTheme.headline6),
    ));
  }
}

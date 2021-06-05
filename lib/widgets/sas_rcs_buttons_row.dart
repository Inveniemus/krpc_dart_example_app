import 'package:flutter/material.dart';

class SASRCSButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(onPressed: () => null, child: Text('SAS')),
        OutlinedButton(onPressed: () => null, child: Text('RCS')),
      ],
    );
  }
}

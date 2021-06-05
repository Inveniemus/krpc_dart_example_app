import 'package:flutter/material.dart';
import '../widgets/sas_rcs_buttons_row.dart';

class SASRCSControlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vessel Control'),),
      body: Column(
        children: [
          SASRCSButtonsRow(),
        ],
      ),
    );
  }
}

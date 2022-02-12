import 'package:flutter/material.dart';

import 'buttons.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[Buttons()],
        ),
      ],
    );
  }
}
